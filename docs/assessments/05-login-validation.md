<p align="center">
  <img src="https://www.cibeg.com/-/media/feature/navigation/footer/logo-white.svg"
       alt="CIB Bank Logo" width="220" style="background:#003366; padding:12px; border-radius:6px;" />
</p>

---

> **📋 This assessment has been assigned to you.**
> Please read the user story and acceptance criteria below, write the Gherkin scenarios, and implement the automation using the tech stack provided.
> **Assessment issued by: CIB — Commercial International Bank**

---

# Assessment 05 — Login Screen (Validation & Error Handling)

## User Story

**As a** registered user who makes an input mistake,
**I want** to see clear, field-level validation messages when I submit incorrect or incomplete login details,
**so that** I understand exactly what I need to fix before I can log in.

---

## Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-05.1 | Submitting the form with an empty email field shows an email validation error |
| AC-05.2 | Submitting the form with an empty password field shows a password validation error |
| AC-05.3 | Submitting the form with both fields empty shows validation errors for both fields |
| AC-05.4 | Entering an email without the `@` symbol and submitting shows an email format error |
| AC-05.5 | Entering an email with a missing domain (e.g. `user@`) and submitting shows an email format error |
| AC-05.6 | Entering a password of fewer than 8 characters and submitting shows a minimum-length error |
| AC-05.7 | Three consecutive failed submission attempts each produce a visible validation error |
| AC-05.8 | Entering a very long email address (> 254 characters) is handled without a crash |

---

## Test Scenarios

```gherkin
Feature: Login Screen — Validation & Error Handling
  As a registered user
  I want to see clear validation messages when I enter incorrect login details
  So that I know exactly how to fix my input

  Background:
    Given the WDIO Native Demo App is installed and launched
    And I tap the "Login" navigation tab

  @P1 @login @validation
  Scenario: L-07 Empty email field shows a validation error
    When I leave the email field empty
    And I enter password "Password1"
    And I tap the Login button
    Then an email validation error message should be displayed

  @P1 @login @validation
  Scenario: L-08 Empty password field shows a validation error
    When I enter email "alice@example.com"
    And I leave the password field empty
    And I tap the Login button
    Then a password validation error message should be displayed

  @P2 @login @validation
  Scenario: L-09 Both fields empty shows validation errors for both
    When I leave the email field empty
    And I leave the password field empty
    And I tap the Login button
    Then an email validation error message should be displayed
    And a password validation error message should be displayed

  @P1 @login @validation
  Scenario Outline: L-10 to L-11 Invalid email format shows an email format error
    When I enter email "<invalidEmail>"
    And I enter password "Password1"
    And I tap the Login button
    Then an email format error message should be displayed

    Examples:
      | invalidEmail    |
      | notanemail      |
      | user@           |
      | @nodomain.com   |
      | plaintext       |

  @P1 @login @validation
  Scenario: L-12 Password shorter than 8 characters shows a minimum-length error
    When I enter email "alice@example.com"
    And I enter password "abc"
    And I tap the Login button
    Then a password minimum-length error message should be displayed

  @P2 @login @validation
  Scenario: L-13 Three consecutive failed attempts each show a validation error
    When I attempt to log in with empty fields 3 times
    Then each attempt should display a validation error message

  @P2 @login @validation
  Scenario: L-14 Very long email address does not crash the app
    When I enter email a string of 260 characters as the email
    And I enter password "Password1"
    And I tap the Login button
    Then the app should remain stable
    And a validation error or graceful message should be shown

  @P2 @login @ui
  Scenario: L-15 Clearing the form resets both fields to empty
    Given I have entered email "alice@example.com" and password "Password1"
    When I clear both input fields
    Then the email field should be empty
    And the password field should be empty
```

---

## Automation Notes

- Validation error messages can be asserted by checking that a `TextView` with specific text (e.g., "Please enter a valid email") becomes visible after form submission.
- For L-13 the step definition should loop the action 3 times and assert the error after each iteration.
- For L-14 use a helper method `StringUtils.repeat("a", 260) + "@test.com"` to build the oversized email.

---

## Deliverables

| # | Item |
|---|------|
| 1 | `features/login_validation.feature` — Gherkin file matching the scenarios above |
| 2 | `steps/LoginSteps.java` — Step definitions (extend from Assessment 04's class) |
| 3 | `pages/LoginPage.java` — Page Object (extend from Assessment 04's class) |
| 4 | All scenarios passing with `mvn test -Dcucumber.filter.tags="@login AND @validation"` |
