/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import type { Meta, StoryObj } from "@storybook/react";
import { ExposureCard } from "../ExposureCard";
import FamilyTreeImage from "../assets/familytree.png";
import TwitterImage from "../assets/twitter-icon.png";
import {
  createRandomBreach,
  createRandomScanResult,
} from "../../../../apiMocks/mockData";

// More on how to set up stories at: https://storybook.js.org/docs/react/writing-stories/introduction
const meta: Meta<typeof ExposureCard> = {
  title: "ExposureCard",
  component: ExposureCard,
  tags: ["autodocs"],
};
export default meta;
type Story = StoryObj<typeof ExposureCard>;

const ScanMockItem = createRandomScanResult();
const BreachMockItem = createRandomBreach();

export const DataBroker: Story = {
  args: {
    exposureImg: FamilyTreeImage,
    exposureData: ScanMockItem,
  },
};

export const DataBreach: Story = {
  args: {
    exposureImg: TwitterImage,
    exposureData: BreachMockItem,
  },
};
