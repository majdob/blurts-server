/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

// TODO: Move pure functions that operate on breaches to this file

export const BreachDataTypes = {
  Passwords: "passwords",
  Email: "email-addresses",
  SSN: "social-security-numbers",
  CreditCard: "partial-credit-card-data",
  BankAccount: "bank-account-numbers",
  PIN: "pins",
  IP: "ip-addresses",
  Address: "physical-addresses",
  DoB: "dates-of-birth",
  Phone: "phone-numbers",
  SecurityQuestions: "security-questions-and-answers",
  HistoricalPasswords: "historical-passwords",
  General: "general",
} as const;

export const ResolutionRelevantBreachDataTypes = {
  Passwords: BreachDataTypes.Passwords,
  Email: BreachDataTypes.Email,
  SSN: BreachDataTypes.SSN,
  CreditCard: BreachDataTypes.CreditCard,
  BankAccount: BreachDataTypes.BankAccount,
  PIN: BreachDataTypes.PIN,
  IP: BreachDataTypes.IP,
  Phone: BreachDataTypes.Phone,
  SecurityQuestions: BreachDataTypes.SecurityQuestions,
} as const;

export const HighRiskDataTypes = {
  SSN: BreachDataTypes.SSN,
  CreditCard: BreachDataTypes.CreditCard,
  BankAccount: BreachDataTypes.BankAccount,
  PIN: BreachDataTypes.PIN,
} as const;

export const LeakedPasswordsDataTypes = {
  Passwords: BreachDataTypes.Passwords,
  SecurityQuestions: BreachDataTypes.SecurityQuestions,
} as const;

export const SecurityRecommendationDataTypes = {
  Email: BreachDataTypes.Email,
  Phone: BreachDataTypes.Phone,
  IP: BreachDataTypes.IP,
} as const;
