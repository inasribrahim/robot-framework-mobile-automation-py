<p align="center">
  <img src="https://www.cibeg.com/-/media/feature/navigation/footer/logo-white.svg"
       alt="CIB Bank Logo" width="220" style="background:#003366; padding:12px; border-radius:6px;" />
</p>

---

> **📋 This assessment has been assigned to you.**
> Please read the user story and acceptance criteria below, write the Gherkin scenarios, and implement the automation using the tech stack provided.
> **Assessment issued by: CIB — Commercial International Bank**

---

# Assessment 07 — Sign Up Screen (Validation & Error Handling)

## User Story

**As a** new user who makes an input mistake during registration,
**I want** to receive clear, field-level validation messages,
**so that** I know exactly which fields to correct before I can create my account.

---

## Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-07.1 | Submitting with an empty email field shows an email validation error |
| AC-07.2 | Submitting with an empty password field shows a password validation error |
| AC-07.3 | Submitting with an empty confirm-password field shows a confirm-password validation error |
| AC-07.4 | Entering an invalid email format and submitting shows an email format error |
| AC-07.5 | Entering a password shorter than 8 characters and submitting shows a minimum-length error |
| AC-07.6 | Entering mismatched password and confirm-password values and submitting shows a mismatch error |
| AC-07.7 | Attempting to sign up with an already-registered email shows an appropriate error (e.g., "Email already exists") |
| AC-07.8 | Two consecutive sign-up attempts with the same email both show the duplicate-email error |
| AC-07.9 | The inline email validation error triggers when the user leaves the email field (on-blur) |
| AC-07.10 | Clearing the form after a failed attempt resets all three fields to empty |

---

## Test Scenarios

```gherkin
Feature: Sign Up Screen — Validation & Error Handling
  As a new user
  I want to see clear validation messages for incorrect registration input
  So that I can fix my mistakes and complete sign-up

  Background:
    Given the WDIO Native Demo App is installed and launched
    And I tap the "Login" navigation tab
    And I tap the "Sign Up" link

  @P1 @signup @validation
  Scenario: S-09 Empty email field shows a validation error
    When I leave the sign-up email field empty
    And I enter sign-up password "Secure123"
    And I enter confirm password "Secure123"
    And I tap the Sign Up button
    Then an email validation error message should be displayed

  @P1 @signup @validation
  Scenario: S-10 Empty password field shows a validation error
    When I enter sign-up email "user@example.com"
    And I leave the sign-up password field empty
    And I enter confirm password "Secure123"
    And I tap the Sign Up button
    Then a password validation error message should be displayed

  @P1 @signup @validation
  Scenario: S-11 Empty confirm-password field shows a validation error
    When I enter sign-up email "user@example.com"
    And I enter sign-up password "Secure123"
    And I leave the confirm password field empty
    And I tap the Sign Up button
    Then a confirm password validation error message should be displayed

  @P1 @signup @validation
  Scenario: S-12 Invalid email format shows an email format error
    When I enter sign-up email "invalidemail"
    And I enter sign-up password "Secure123"
    And I enter confirm password "Secure123"
    And I tap the Sign Up button
    Then an email format error message should be displayed

  @P1 @signup @validation
  Scenario: S-13 Password shorter than 8 characters shows a minimum-length error
    When I enter sign-up email "user@example.com"
    And I enter sign-up password "short"
    And I enter confirm password "short"
    And I tap the Sign Up button
    Then a password minimum-length error message should be displayed

  @P1 @signup @validation
  Scenario: S-14 Mismatched passwords show a confirm-password error
    When I enter sign-up email "user@example.com"
    And I enter sign-up password "Secure123"
    And I enter confirm password "Different456"
    And I tap the Sign Up button
    Then a password mismatch error message should be displayed

  @P1 @signup @validation
  Scenario: S-15 Duplicate email shows an already-registered error
    Given a user with email "existing@example.com" is already registered
    When I enter sign-up email "existing@example.com"
    And I enter sign-up password "Secure123"
    And I enter confirm password "Secure123"
    And I tap the Sign Up button
    Then an error message indicating the email is already registered should be displayed

  @P2 @signup @validation
  Scenario: S-16 Two consecutive duplicate-email attempts both show the error
    Given a user with email "existing@example.com" is already registered
    When I attempt to sign up with "existing@example.com" twice
    Then both attempts should display the duplicate-email error

  @P2 @signup @validation
  Scenario: S-17 Inline email validation triggers on blur
    When I enter sign-up email "bademail"
    And I tap the password field to move focus away from email
    Then an inline email validation error should be visible without tapping Sign Up

  @P2 @signup @validation
  Scenario: S-18 Clearing the form after a failed attempt resets all fields
    Given I have filled all sign-up fields with invalid data and seen a validation error
    When I clear all sign-up fields
    Then the email field should be empty
    And the password field should be empty
    And the confirm password field should be empty
```

---

## Automation Notes

- For S-15 and S-16, set up precondition data in `@Before` hook or use a dedicated background step that calls the registration API / performs a prior registration via the UI.
- S-17 tests *on-blur* validation — tap the email field, type an invalid email, then tap another field (password) before tapping Sign Up.
- Duplicate-email handling (S-15) depends on app state: if the app resets between tests, use a `@Before` hook to pre-register the email first.

---

## Deliverables

| # | Item |
|---|------|
| 1 | `features/signup_validation.feature` — Gherkin file matching the scenarios above |
| 2 | `steps/SignUpSteps.java` — Step definitions (extend from Assessment 06's class) |
| 3 | `pages/SignUpPage.java` — Page Object (extend from Assessment 06's class) |
| 4 | All scenarios passing with `mvn test -Dcucumber.filter.tags="@signup AND @validation"` |
