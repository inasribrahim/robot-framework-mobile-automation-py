<p align="center">
  <img src="https://www.cibeg.com/-/media/feature/navigation/footer/logo-white.svg"
       alt="CIB Bank Logo" width="220" style="background:#003366; padding:12px; border-radius:6px;" />
</p>

---

> **📋 This assessment has been assigned to you.**
> Please read the user story and acceptance criteria below, write the Gherkin scenarios, and implement the automation using the tech stack provided.
> **Assessment issued by: CIB — Commercial International Bank**

---

# Assessment 02 — Home Screen

## User Story

**As a** first-time or returning user,
**I want** to see a welcoming home screen immediately when the app opens,
**so that** I have a recognisable starting point and can confirm the app has loaded correctly.

---

## Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-02.1 | The Home screen is the first screen displayed when the app launches |
| AC-02.2 | The app logo is visible on the Home screen |
| AC-02.3 | A welcome title or heading text is visible on the Home screen |
| AC-02.4 | The Home screen is restored in full when the user navigates away and taps the Home tab again |
| AC-02.5 | No loading spinner or error is displayed longer than 5 seconds on Home screen launch |

---

## Test Scenarios

```gherkin
Feature: Home Screen
  As a mobile app user
  I want to see the Home screen on launch
  So that I know the app is running and ready

  Background:
    Given the WDIO Native Demo App is installed and launched

  @smoke @P0 @home
  Scenario: H-01 Home screen is the first screen shown on app launch
    Then I should see the "Home" screen
    And the navigation bar should be visible

  @P2 @home
  Scenario: H-02 App logo is visible on the Home screen
    Given I am on the "Home" screen
    Then the app logo should be visible

  @P2 @home
  Scenario: H-03 Welcome title is visible on the Home screen
    Given I am on the "Home" screen
    Then a welcome heading or title text should be displayed

  @P2 @home
  Scenario: H-04 Home screen is restored after navigating away and back
    Given I am on the "Home" screen
    When I tap the "Login" navigation tab
    And I tap the "Home" navigation tab
    Then I should see the "Home" screen
    And the app logo should be visible

  @P2 @home
  Scenario: H-05 Home screen loads without a long-running spinner
    When the app launches
    Then the Home screen content should be visible within 5 seconds
```

---

## Automation Notes

- H-01 is **P0** — it must be included in the smoke suite and must pass in CI.
- The "app logo" visible check (H-02) can use `element should be visible` on the image element's `accessibility_id` or `resource-id`.
- For H-05, capture the launch time using a before/after timestamp comparison in the step definition.

---

## Deliverables

| # | Item |
|---|------|
| 1 | `features/home.feature` — Gherkin file matching the scenarios above |
| 2 | `steps/HomeSteps.java` — Step definitions for all Home steps |
| 3 | `pages/HomePage.java` — Page Object with all locators and actions |
| 4 | All scenarios passing with `mvn test -Dcucumber.filter.tags="@home"` |
