<p align="center">
  <img src="https://www.cibeg.com/-/media/feature/navigation/footer/logo-white.svg"
       alt="CIB Bank Logo" width="220" style="background:#003366; padding:12px; border-radius:6px;" />
</p>

---

> **📋 This assessment has been assigned to you.**
> Please read the user story and acceptance criteria below, write the Gherkin scenarios, and implement the automation using the tech stack provided.
> **Assessment issued by: CIB — Commercial International Bank**

---

# Assessment 04 — Login Screen (Happy Path)

## User Story

**As a** registered user,
**I want** to log in to the application using my email address and password,
**so that** I can access my account and the app's protected features.

---

## Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-04.1 | The Login screen shows an email input field, a password input field, and a Login button |
| AC-04.2 | Entering a valid email and password and tapping Login displays a success alert |
| AC-04.3 | The success alert contains a positive confirmation message |
| AC-04.4 | Dismissing the success alert returns the user to the Login screen |
| AC-04.5 | The password field masks its characters (shown as dots or asterisks) |
| AC-04.6 | A valid password that contains special characters (`!@#$%^&*`) is accepted |
| AC-04.7 | Login session state persists when the app is backgrounded and then brought back to the foreground |

---

## Test Scenarios

```gherkin
Feature: Login Screen — Happy Path
  As a registered user
  I want to log in with valid credentials
  So that I can access the app

  Background:
    Given the WDIO Native Demo App is installed and launched
    And I tap the "Login" navigation tab

  @smoke @P0 @login @happy-path
  Scenario: L-01 Successful login with valid credentials shows a success alert
    When I enter email "alice@example.com"
    And I enter password "Password1"
    And I tap the Login button
    Then a success alert should be displayed
    And the success alert should contain a confirmation message

  @P2 @login @happy-path
  Scenario: L-02 Dismissing the success alert returns to the Login screen
    Given I have logged in successfully with "alice@example.com" and "Password1"
    When I dismiss the success alert
    Then I should see the "Login" screen

  @P2 @login @security
  Scenario: L-03 Password field masks its characters
    When I enter password "Secret123"
    Then the password field input should be masked

  @P1 @login @happy-path
  Scenario: L-04 Login with a password containing special characters succeeds
    When I enter email "alice@example.com"
    And I enter password "P@ssw0rd!#"
    And I tap the Login button
    Then a success alert should be displayed

  @P2 @login @resilience
  Scenario: L-05 Login session persists after the app is backgrounded and reactivated
    Given I have logged in successfully with "alice@example.com" and "Password1"
    And I dismiss the success alert
    When I send the app to the background for 3 seconds
    And I bring the app back to the foreground
    Then I should see the "Login" screen

  @P2 @login @ui
  Scenario: L-06 All required Login screen elements are visible
    Then the email input field should be visible
    And the password input field should be visible
    And the Login button should be visible
```

---

## Automation Notes

- L-01 is **P0** — must be in the smoke suite and must pass in CI.
- Use `driver.runAppInBackground(Duration.ofSeconds(3))` for L-05 background/foreground check.
- For L-03 password masking, verify that the password field attribute `password` is `true` or that input type is `textPassword`.

---

## Deliverables

| # | Item |
|---|------|
| 1 | `features/login_happy_path.feature` — Gherkin file matching the scenarios above |
| 2 | `steps/LoginSteps.java` — Step definitions for all Login steps |
| 3 | `pages/LoginPage.java` — Page Object with all locators and actions |
| 4 | All scenarios passing with `mvn test -Dcucumber.filter.tags="@login"` |
