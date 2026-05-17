<p align="center">
  <img src="https://www.cibeg.com/-/media/feature/navigation/footer/logo-white.svg"
       alt="CIB Bank Logo" width="220" style="background:#003366; padding:12px; border-radius:6px;" />
</p>

---

> **📋 This assessment has been assigned to you.**
> Please read the user story and acceptance criteria below, write the Gherkin scenarios, and implement the automation using the tech stack provided.
> **Assessment issued by: CIB — Commercial International Bank**

---

# Assessment 01 — Navigation Bar

## User Story

**As a** mobile app user,
**I want** to navigate between the app's main screens using the bottom navigation bar,
**so that** I can quickly access any section of the app without losing my current context.

---

## Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-01.1 | The navigation bar is always visible at the bottom of every main screen |
| AC-01.2 | The navigation bar contains exactly 5 tabs: **Home**, **Webview**, **Login**, **Forms**, **Swipe** |
| AC-01.3 | Tapping any tab navigates the user to the corresponding screen |
| AC-01.4 | The currently active tab is visually highlighted (e.g., colour, icon weight) |
| AC-01.5 | Navigating to a tab and then tapping a previous tab restores that screen |
| AC-01.6 | No tab press causes the app to crash or produce an unhandled error |

---

## Test Scenarios

```gherkin
Feature: Navigation Bar
  As a mobile app user
  I want to use the bottom navigation bar
  So that I can switch between screens quickly

  Background:
    Given the WDIO Native Demo App is installed and launched

  @smoke @P1 @navigation
  Scenario: N-01 All five navigation tabs are visible on launch
    Then I should see 5 tabs in the navigation bar
    And the tabs should be labelled "Home", "Webview", "Login", "Forms", and "Swipe"

  @smoke @P1 @navigation
  Scenario Outline: N-02 to N-06 Tapping each tab displays the correct screen
    When I tap the "<tab>" navigation tab
    Then I should see the "<expectedScreen>" screen

    Examples:
      | tab     | expectedScreen |
      | Home    | Home           |
      | Webview | Webview        |
      | Login   | Login          |
      | Forms   | Forms          |
      | Swipe   | Swipe          |

  @P2 @navigation
  Scenario: N-07 The active tab is visually highlighted
    When I tap the "Login" navigation tab
    Then the "Login" tab should appear visually active
    And the other tabs should appear visually inactive

  @P2 @navigation
  Scenario: N-08 Navigating away and back restores the previous screen
    Given I am on the "Home" screen
    When I tap the "Login" navigation tab
    And I tap the "Home" navigation tab
    Then I should see the "Home" screen

  @P2 @navigation
  Scenario: N-09 No tab press causes a crash
    When I tap each navigation tab in sequence
    Then the app should remain stable with no error dialogs
```

---

## Automation Notes

- Use `accessibility_id` locators where available (e.g., `accessibility_id=Home`).
- The "visually active" state (N-07) can be verified via `content-desc`, attribute `selected=true`, or a screenshot assertion.
- Implement tab navigation in `NavigationBarPO` (Page Object), never directly in step definitions.

---

## Deliverables

| # | Item |
|---|------|
| 1 | `features/navigation.feature` — Gherkin file matching the scenarios above |
| 2 | `steps/NavigationSteps.java` — Step definitions for all Navigation steps |
| 3 | `pages/NavigationBarPage.java` — Page Object with all locators and actions |
| 4 | All scenarios passing with `mvn test -Dcucumber.filter.tags="@navigation"` |
