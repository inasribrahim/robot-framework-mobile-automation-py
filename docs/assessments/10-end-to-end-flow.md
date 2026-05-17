<p align="center">
  <img src="https://www.cibeg.com/-/media/feature/navigation/footer/logo-white.svg"
       alt="CIB Bank Logo" width="220" style="background:#003366; padding:12px; border-radius:6px;" />
</p>

---

> **📋 This assessment has been assigned to you.**
> Please read the user story and acceptance criteria below, write the Gherkin scenarios, and implement the automation using the tech stack provided.
> **Assessment issued by: CIB — Commercial International Bank**

---

# Assessment 10 — End-to-End Flow

## User Story

**As a** QA engineer,
**I want** to verify that a new user can register, log in, explore multiple screens, and interact with form controls — all in a single continuous flow,
**so that** I can confirm that the core user journey works correctly from start to finish.

---

## Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-10.1 | A new user can navigate to the Sign Up screen from the Login screen |
| AC-10.2 | A new user can complete registration and see a success alert |
| AC-10.3 | After dismissing the success alert the user can navigate to the Login screen |
| AC-10.4 | The newly registered user can log in and see a success alert |
| AC-10.5 | After a successful login the user can navigate to the Forms screen and interact with form controls |
| AC-10.6 | From the Forms screen the user can navigate to the Swipe screen and swipe a card |
| AC-10.7 | The navigation bar remains accessible and functional throughout the entire journey |
| AC-10.8 | No unhandled errors or crashes occur at any step of the end-to-end flow |

---

## Test Scenarios

```gherkin
Feature: End-to-End User Journey
  As a QA engineer
  I want to run a complete user journey from registration to interacting with all main screens
  So that I can verify the core flow works without errors

  Background:
    Given the WDIO Native Demo App is installed and launched

  @smoke @P0 @e2e
  Scenario: E2E-01 Full new-user journey — Register → Login → Explore
    # Step 1: Navigate to Sign Up
    When I tap the "Login" navigation tab
    And I tap the "Sign Up" link
    Then I should see the "Sign Up" screen

    # Step 2: Register
    When I enter sign-up email "e2euser@example.com"
    And I enter sign-up password "E2eTest1!"
    And I enter confirm password "E2eTest1!"
    And I tap the Sign Up button
    Then a success alert should be displayed

    # Step 3: Go to Login
    When I dismiss the success alert
    And I tap the "Login" navigation tab
    Then I should see the "Login" screen

    # Step 4: Log in
    When I enter email "e2euser@example.com"
    And I enter password "E2eTest1!"
    And I tap the Login button
    Then a success alert should be displayed

    # Step 5: Explore Forms
    When I dismiss the success alert
    And I tap the "Forms" navigation tab
    Then I should see the "Forms" screen
    When I tap the text input field
    And I type "E2E Test"
    Then the text input field should display "E2E Test"

    # Step 6: Explore Swipe
    When I tap the "Swipe" navigation tab
    Then I should see the "Swipe" screen
    When I swipe the first visible card to the left
    Then the card should be removed from view or its content should be revealed

  @P2 @e2e @navigation
  Scenario: E2E-02 Navigation bar is accessible and functional throughout the journey
    When I tap the "Login" navigation tab
    And I tap the "Forms" navigation tab
    And I tap the "Swipe" navigation tab
    And I tap the "Webview" navigation tab
    And I tap the "Home" navigation tab
    Then I should see the "Home" screen
    And no error or crash should have occurred

  @P2 @e2e
  Scenario: E2E-03 Complete journey produces no unhandled errors
    When I perform the full new-user journey
    Then the app should remain stable throughout
    And no system error dialogs should appear at any step

  @P2 @e2e @performance
  Scenario: E2E-04 The registration and login steps complete within acceptable time
    When I complete the sign-up flow with valid data
    Then the sign-up success alert should appear within 10 seconds
    When I complete the login flow with the same credentials
    Then the login success alert should appear within 10 seconds
```

---

## Automation Notes

- E2E-01 is **P0** — it is the most important scenario in the entire suite. It must run in CI.
- Use a `@Before` hook tagged `@e2e` to reset app state (clear app data or reinstall) before E2E tests so they start clean.
- For unique email addresses in E2E runs, generate them with a timestamp: `"e2e_" + System.currentTimeMillis() + "@test.com"`.
- Share step definitions with the feature-specific step classes (NavigationSteps, LoginSteps, SignUpSteps, FormsSteps, SwipeSteps) — do **not** duplicate steps.
- Use the `@CucumberOptions` `glue` path to include all step packages in the E2E runner.

---

## Deliverables

| # | Item |
|---|------|
| 1 | `features/e2e_flow.feature` — Gherkin file matching the scenarios above |
| 2 | `steps/` — Reuse existing step definition classes; no duplicate step code |
| 3 | `runners/E2ERunner.java` — Dedicated TestNG + Cucumber runner for the E2E suite |
| 4 | All E2E scenarios passing with `mvn test -Dcucumber.filter.tags="@e2e"` |
| 5 | E2E suite included in the GitHub Actions pipeline as a required check |
