/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import { getServerSession } from "next-auth";
import { authOptions } from "../../../../utils/auth";
import { NextRequest, NextResponse } from "next/server";

import { logger } from "../../../../../functions/server/logging";

import {
  createProfile,
  createScan,
  isEligibleForFreeScan,
} from "../../../../../functions/server/onerep";
import type { CreateProfileRequest } from "../../../../../functions/server/onerep";
import { meetsAgeRequirement } from "../../../../../functions/universal/user";
import AppConstants from "../../../../../../appConstants";
import { getSubscriberByEmail } from "../../../../../../db/tables/subscribers";
import {
  setOnerepProfileId,
  setOnerepScan,
} from "../../../../../../db/tables/onerep_scans";
import { setProfileDetails } from "../../../../../../db/tables/onerep_profiles";
import { StateAbbr } from "../../../../../../utils/states";
import { ISO8601DateString } from "../../../../../../utils/parse";
import { getCountryCode } from "../../../../../functions/server/getCountryCode";
import { headers } from "next/headers";

export interface WelcomeScanBody {
  success: boolean;
}

export interface UserInfo {
  firstName: string;
  lastName: string;
  city: string;
  state: StateAbbr;
  dateOfBirth: ISO8601DateString;
}

export async function POST(
  req: NextRequest,
): Promise<NextResponse<WelcomeScanBody> | NextResponse<unknown>> {
  const session = await getServerSession(authOptions);
  if (!session?.user?.subscriber) {
    throw new Error("No session");
  }

  const eligible = await isEligibleForFreeScan(
    session.user,
    getCountryCode(headers()),
  );
  if (!eligible) {
    throw new Error("User is not eligible for feature");
  }

  const params: UserInfo = await req.json();
  const requiredParamKeys: Array<keyof UserInfo> = [
    "firstName",
    "lastName",
    "city",
    "state",
    "dateOfBirth",
  ];
  requiredParamKeys.forEach((requiredParamKey) => {
    if (!params[requiredParamKey]) {
      throw new Error(`${requiredParamKey} is required`);
    }
  });

  const { firstName, lastName, city, state, dateOfBirth } = params;
  if (!meetsAgeRequirement(dateOfBirth)) {
    throw new Error(`User does not meet the age requirement: ${dateOfBirth}`);
  }
  const profileData: CreateProfileRequest = {
    first_name: firstName,
    last_name: lastName,
    addresses: [{ city, state }],
    birth_date: dateOfBirth,
  };

  if (typeof session?.user?.email === "string") {
    try {
      const subscriber = await getSubscriberByEmail(session.user.email);

      if (!subscriber.onerep_profile_id) {
        // Create OneRep profile
        const profileId = await createProfile(profileData);
        await setOnerepProfileId(subscriber, profileId);
        await setProfileDetails(profileId, profileData);

        // Start exposure scan
        const scan = await createScan(profileId);
        const scanId = scan.id;
        await setOnerepScan(profileId, scanId, scan.status, "manual");

        return NextResponse.json({ success: true }, { status: 200 });
      }

      return NextResponse.json({ success: true }, { status: 200 });
    } catch (e) {
      logger.error(e);
      return NextResponse.json({ success: false }, { status: 500 });
    }
  } else {
    // Not Signed in, redirect to home
    return NextResponse.redirect(AppConstants.SERVER_URL, 302);
  }
}
