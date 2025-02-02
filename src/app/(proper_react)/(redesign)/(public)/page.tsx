/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import { headers } from "next/headers";
import { getServerSession } from "next-auth";
import { redirect } from "next/navigation";
import { getCountryCode } from "../../../functions/server/getCountryCode";
import {
  isEligibleForPremium,
  getProfilesStats,
  monthlySubscribersQuota,
} from "../../../functions/server/onerep";
import { getEnabledFeatureFlags } from "../../../../db/tables/featureFlags";
import { getL10n } from "../../../functions/server/l10n";
import { View } from "./LandingView";

export default async function Page() {
  const session = await getServerSession();
  if (typeof session?.user.email === "string") {
    return redirect("/user/dashboard/");
  }
  const enabledFlags = await getEnabledFeatureFlags({ ignoreAllowlist: true });
  const countryCode = getCountryCode(headers());
  const eligibleForPremium = isEligibleForPremium(countryCode, enabledFlags);

  // request the profile stats for the last 30 days
  const profileStats = await getProfilesStats(
    new Date(Date.now() - 30 * 24 * 60 * 60 * 1000),
  );
  const oneRepActivations = profileStats?.total_active;
  const scanLimitReached =
    typeof oneRepActivations === "undefined" ||
    oneRepActivations > monthlySubscribersQuota;
  return (
    <View
      eligibleForPremium={eligibleForPremium}
      l10n={getL10n()}
      countryCode={countryCode}
      scanLimitReached={scanLimitReached}
    />
  );
}
