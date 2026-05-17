<p align="center">
  <img src="https://www.cibeg.com/-/media/feature/navigation/footer/logo-white.svg"
       alt="CIB Bank Logo" width="220" style="background:#003366; padding:12px; border-radius:6px;" />
</p>

---

> **📋 This assessment has been assigned to you.**
> Please read the user story and acceptance criteria below, write the Gherkin scenarios, and implement the automation using the tech stack provided.
> **Assessment issued by: CIB — Commercial International Bank**

---

# Assessment 06 — Sign Up Screen (Happy Path)

## User Story

**As a** new user,
**I want** to create an account by providing my email address and a secure password,
**so that** I can start using the application's features.

---

## Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-06.1 | The Sign Up screen is accessible via the "Sign Up" link on the Login screen |
| AC-06.2 | The Sign Up screen shows an email field, a password field, and a confirm-password field |
| AC-06.3 | Filling in a valid email, a password ≥ 8 characters, and a matching confirm-password and tapping Sign Up shows a success alert |
| AC-06.4 | The success alert contains a positive registration confirmation message |
| AC-06.5 | Dismissing the success alert keeps or returns the user to the Sign Up screen |
| AC-06.6 | Both password fields mask their characters |
| AC-06.7 | A valid password containing special characters (`!@#$%`) is accepted |
| AC-06.8 | A password of exactly 8 characters (boundary value) is accepted |
| AC-06.9 | An email entered in upper-case (e.g., `ALICE@EXAMPLE.COM`) is treated as valid |
| AC-06.10 | The full sign-up flow (open screen → fill form → success alert) completes within 30 seconds |

---

## Test Scenarios

```gherkin
Feature: Sign Up Screen — Happy Path
  As a new user
  I want to register a new account with valid details
  So that I can start using the app

  Background:
    Given the WDIO Native Demo App is installed and launched
    And I tap the "Login" navigation tab
    And I tap the "Sign Up" link

  @smoke @P0 @signup @happy-path
  Scenario: S-01 Successful sign-up with valid details shows a success alert
    When I enter sign-up email "newuser@example.com"
    And I enter sign-up password "Secure123"
    And I enter confirm password "Secure123"
    And I tap the Sign Up button
    Then a success alert should be displayed
    And the success alert should contain a registration confirmation message

  @P2 @signup @happy-path
  Scenario: S-02 Dismissing the success alert stays on the Sign Up screen
    Given I have signed up successfully with "newuser@example.com" and "Secure123"
    When I dismiss the success alert
    Then I should see the "Sign Up" screen

  @P2 @signup @security
  Scenario: S-03 Both password fields mask their characters
    When I enter sign-up password "HiddenPass1"
    And I enter confirm password "HiddenPass1"
    Then the password field input should be masked
    And the confirm password field input should be masked

  @P1 @signup @happy-path
  Scenario: S-04 Sign-up with a password containing special characters succeeds
    When I enter sign-up email "specialchars@example.com"
    And I enter sign-up password "P@ssw0rd!#"
    And I enter confirm password "P@ssw0rd!#"
    And I tap the Sign Up button
    Then a success alert should be displayed

  @P1 @signup @boundary
  Scenario: S-05 Sign-up with exactly 8-character password (boundary) succeeds
    When I enter sign-up email "boundary@example.com"
    And I enter sign-up password "Pass1234"
    And I enter confirm password "Pass1234"
    And I tap the Sign Up button
    Then a success alert should be displayed

  @P2 @signup @happy-path
  Scenario: S-06 Sign-up with an upper-case email is accepted
    When I enter sign-up email "UPPER@EXAMPLE.COM"
    And I enter sign-up password "Secure123"
    And I enter confirm password "Secure123"
    And I tap the Sign Up button
    Then a success alert should be displayed

  @P2 @signup @performance
  Scenario: S-07 Full sign-up flow completes within 30 seconds
    When I complete the full sign-up flow with valid data
    Then the success alert should appear within 30 seconds

  @P2 @signup @ui
  Scenario: S-08 All required Sign Up screen elements are visible
    Then the email input field should be visible
    And the password input field should be visible
    And the confirm password input field should be visible
    And the Sign Up button should be visible
```

---

## Automation Notes

- S-01 is **P0** — must be in the smoke suite and must pass in CI.
- The Sign Up link on the Login screen can be located by `accessibility_id=button-sign-up`.
- Use `StopWatch` from Apache Commons to measure elapsed time for S-07.
- For S-06 upper-case email, assert that the success alert appears (the app should normalise the case).

---

## Deliverables

| # | Item |
|---|------|
| 1 | `features/signup_happy_path.feature` — Gherkin file matching the scenarios above |
| 2 | `steps/SignUpSteps.java` — Step definitions for all Sign Up steps |
| 3 | `pages/SignUpPage.java` — Page Object with all locators and actions |
| 4 | All scenarios passing with `mvn test -Dcucumber.filter.tags="@signup"` |
