/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Sentry from "@sentry/nextjs"
import { acceptedLanguages, negotiateLanguages } from "@fluent/langneg";

import * as pubsub from "@google-cloud/pubsub";
import * as grpc from "@grpc/grpc-js";

import { getSubscribersByHashes, knexSubscribers } from "../db/tables/subscribers.js";
import { getEmailAddressesByHashes, knexEmailAddresses } from "../db/tables/emailAddresses.js";
import { getTemplate } from "../views/emails/email2022.js";
import { breachAlertEmailPartial } from "../views/emails/emailBreachAlert.js";

import {
  initEmail,
  EmailTemplateType,
  getEmailCtaHref,
  sendEmail,
} from "../utils/email.js";

import { initFluentBundles, getMessage } from "../utils/fluent.js";
import {
  getAddressesAndLanguageForEmail,
  getBreachByName,
  getAllBreachesFromDb,
  knexHibp
} from "../utils/hibp.js";

const SENTRY_SLUG = "cron-breach-alerts";

Sentry.init({
  environment: process.env.APP_ENV,
  dsn: process.env.SENTRY_DSN,
  tracesSampleRate: 1.0,
});

const checkInId = Sentry.captureCheckIn({
  monitorSlug: SENTRY_SLUG,
  status: "in_progress",
});

// Only process this many messages before exiting.
const maxMessages = 1000;
const projectId = process.env.GCP_PUBSUB_PROJECT_ID;
const subscriptionName = process.env.GCP_PUBSUB_SUBSCRIPTION_NAME;

/**
 * Fetch the latest HIBP breach data from GCP PubSub queue.
 * 
 * A breach notification contains the following parameters:
 * - breachName
 * - hashPrefix
 * - hashSuffixes
 * 
 * More about how account identities are anonymized: https://blog.mozilla.org/security/2018/06/25/scanning-breached-accounts-k-anonymity/
 * @param {pubsub.v1.SubscriberClient} subClient
 * @param {pubsub.protos.google.pubsub.v1.IReceivedMessage[]} receivedMessages
 */
export async function poll(subClient, receivedMessages) {
  const formattedSubscription = subClient.subscriptionPath(
    projectId ?? "",
    subscriptionName ?? ""
  );

  // Process the messages. Skip any that cannot be processed, and do not mark as acknowledged.
  for (const message of receivedMessages) {
    const messageData = message?.message?.data;
    if (!messageData) {
      console.error("HIBP breach notification missing message data");
      continue;
    }
    console.log(`Received message: ${messageData}`);
    const data = JSON.parse(messageData.toString());

    if (!(data.breachName && data.hashPrefix && data.hashSuffixes)) {
      console.error(
        "HIBP breach notification: requires breachName, hashPrefix, and hashSuffixes."
      );
      continue;
    }

    const { breachName, hashPrefix, hashSuffixes } = data;

    const breaches = await getAllBreachesFromDb();
    const breachAlert = getBreachByName(breaches, breachName);

    const { IsVerified, Domain, IsFabricated, IsSpamList } = breachAlert;

    // If any of the following conditions are not satisfied:
    // Do not send the breach alert email! The `logId`s are being used for
    // logging in case we decide to not send the alert.
    const emailDeliveryConditions = [
      {
        logId: "isNotVerified",
        condition: !IsVerified,
      },
      {
        logId: "domainEmpty",
        condition: Domain === "",
      },
      {
        logId: "isFabricated",
        condition: IsFabricated,
      },
      {
        logId: "isSpam",
        condition: IsSpamList,
      },
    ];

    const unsatisfiedConditions = emailDeliveryConditions.filter(
      (condition) => condition.condition
    );

    const doNotSendEmail = unsatisfiedConditions.length > 0;

    if (doNotSendEmail) {
      // Get a list of the failed condition `logId`s
      const conditionLogIds = unsatisfiedConditions
        .map((condition) => condition.logId)
        .join(", ");

      console.info("Breach alert email was not sent.", {
        name: breachAlert.Name,
        reason: `The following conditions were not satisfied: ${conditionLogIds}.`,
      });

      if (typeof message.ackId !== "string") {
        console.error("No ackID on message:", messageData);
        continue;
      }
      subClient.acknowledge({
        subscription: formattedSubscription,
        ackIds: [message.ackId],
      });

      continue;
    }

    try {
      const reqHashPrefix = hashPrefix.toLowerCase();
      const hashes = hashSuffixes.map(
        (/** @type {string} */ suffix) => reqHashPrefix + suffix.toLowerCase()
      );

      const subscribers = await getSubscribersByHashes(hashes);
      const emailAddresses = await getEmailAddressesByHashes(hashes);
      const recipients = subscribers.concat(emailAddresses);

      console.info(EmailTemplateType.Notification, {
        breachAlertName: breachAlert.Name,
        length: recipients.length,
      });

      const utmCampaignId = "breach-alert";
      /**
       * @type {any[]}
       */
      const notifiedRecipients = [];

      for (const recipient of recipients) {
        console.info("notify", { recipient });

        // Get subscriber ID from:
        // - `subscriber_id`: if `email_addresses` record
        // - `id`: if `subscribers` record
        const subscriberId = recipient.subscriber_id ?? recipient.id;
        const { recipientEmail, breachedEmail, signupLanguage } =
          getAddressesAndLanguageForEmail(recipient);

        /* c8 ignore start */
        const requestedLanguage = signupLanguage
          ? acceptedLanguages(signupLanguage)
          : [];
        /* c8 ignore stop */

        const availableLanguages = process.env.SUPPORTED_LOCALES?.split(",") ?? [];
        const supportedLocales = negotiateLanguages(
          requestedLanguage,
          availableLanguages,
          { defaultLocale: "en" }
        );

        if (!notifiedRecipients.includes(breachedEmail)) {
          const data = {
            breachData: breachAlert,
            breachLogos: [], // FIXME this appears to be unused?
            breachedEmail,
            ctaHref: getEmailCtaHref(utmCampaignId, "dashboard-cta"),
            heading: getMessage("email-spotted-new-breach"),
            recipientEmail,
            subscriberId,
            supportedLocales,
            utmCampaign: utmCampaignId,
          };

          const emailTemplate = getTemplate(data, breachAlertEmailPartial);
          const subject = getMessage("breach-alert-subject");

          await sendEmail(data.recipientEmail, subject, emailTemplate);

          notifiedRecipients.push(breachedEmail);
        }
      }

      console.info("notified", { length: notifiedRecipients.length });

      if (typeof message.ackId !== "string") {
        console.error("No ackID on message:", messageData);
        continue;
      }

      subClient.acknowledge({
        subscription: formattedSubscription,
        ackIds: [message.ackId],
      });
    /* c8 ignore start */
    } catch (error) {
      console.error(`Notifying subscribers of breach failed: ${error}`);
    }
    /* c8 ignore stop */
  }
}

/* c8 ignore start */
/**
 * 
 * @returns Promise<[pubsub.v1.SubscriberClient, pubsub.protos.google.pubsub.v1.IReceivedMessage[]]>
 */
async function pullMessages() {
  let subClient;
  if (process.env.NODE_ENV === "development") {
    console.debug("Dev mode, connecting to local pubsub emulator");
    subClient = new pubsub.v1.SubscriberClient({
      servicePath: "localhost",
      port: 8085,
      sslCreds: grpc.credentials.createInsecure()
    });
  } else {
    subClient = new pubsub.v1.SubscriberClient();
  }

  const formattedSubscription = subClient.subscriptionPath(
    projectId ?? "",
    subscriptionName ?? ""
  );

  // If there are no messages, this will wait until the default timeout for the pull API.
  // @see https://cloud.google.com/pubsub/docs/pull
  console.debug("polling pubsub...");
  const [response] = await subClient.pull({
    subscription: formattedSubscription,
    maxMessages,
  });

  return [subClient, response.receivedMessages];
}
async function init() {
  await initFluentBundles();
  await initEmail();

  const [subClient, receivedMessages] = await pullMessages();
  //@ts-expect-error TODO cast this properly using JSDoc
  await poll(subClient, receivedMessages);
}

if (process.env.NODE_ENV !== "test") {
  init()
    .then(async (_res) => {
      if (!(projectId && subscriptionName)) {
        throw new Error("env vars not set: GCP_PUBSUB_PROJECT_ID and GCP_PUBSUB_SUBSCRIPTION_NAME")
      }
      Sentry.captureCheckIn({
        checkInId,
        monitorSlug: SENTRY_SLUG,
        status: "ok",
      });
    })
    .catch((err) => console.error(err))
    .finally(async() => {
      // Tear down knex connection pools
      await knexSubscribers.destroy();
      await knexEmailAddresses.destroy();
      await knexHibp.destroy();
    });
}
/* c8 ignore stop */
