<p align="center">
  <img src="https://www.cibeg.com/-/media/feature/navigation/footer/logo-white.svg"
       alt="CIB Bank Logo" width="220" style="background:#003366; padding:12px; border-radius:6px;" />
</p>

---

> **📋 This assessment has been assigned to you.**
> Please read the user story and acceptance criteria below, write the Gherkin scenarios, and implement the automation using the tech stack provided.
> **Assessment issued by: CIB — Commercial International Bank**

---

# Assessment 03 — Webview Screen

## User Story

**As a** mobile app user,
**I want** to view and navigate to web pages inside the app's Webview screen,
**so that** I can access online content without leaving the application.

---

## Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-03.1 | The Webview screen is displayed when the Webview tab is tapped |
| AC-03.2 | An address bar (URL input field) is visible on the Webview screen |
| AC-03.3 | A default URL is pre-loaded and visible in the address bar on screen open |
| AC-03.4 | The user can clear the address bar, type a new URL, and load that page |
| AC-03.5 | The webview area renders actual page content (not a blank or error screen) |
| AC-03.6 | After navigating to a custom URL, tapping the system Back button keeps the user on the Webview screen |

---

## Test Scenarios

```gherkin
Feature: Webview Screen
  As a mobile app user
  I want to browse web content inside the app
  So that I do not need to leave the app to access URLs

  Background:
    Given the WDIO Native Demo App is installed and launched
    And I tap the "Webview" navigation tab

  @smoke @P1 @webview
  Scenario: W-01 Webview screen is displayed when the tab is tapped
    Then I should see the "Webview" screen
    And the address bar should be visible

  @P1 @webview
  Scenario: W-02 A default URL is pre-loaded in the address bar
    Then the address bar should contain a non-empty URL

  @P1 @webview
  Scenario: W-03 User can type a custom URL and navigate to it
    When I clear the address bar
    And I type "https://webdriver.io" in the address bar
    And I submit the address bar
    Then the webview should display content from "webdriver.io"

  @P2 @webview
  Scenario: W-04 Webview renders page content, not a blank or error page
    Then the webview area should contain visible page content
    And no browser error message should be displayed

  @P2 @webview
  Scenario: W-05 Navigating back after loading a page keeps the user on the Webview screen
    When I clear the address bar
    And I type "https://example.com" in the address bar
    And I submit the address bar
    And I press the device back button
    Then I should still see the "Webview" screen
```

---

## Automation Notes

- To interact with the webview content itself you may need to switch the driver context to `WEBVIEW_*` using `driver.context(webviewContext)`.
- For the address bar, check whether it is a native `EditText` or inside the webview context.
- W-04 "visible page content" can be verified by asserting that the webview's `contentDescription` or child elements are non-empty, or by switching context and checking `document.title`.

---

## Deliverables

| # | Item |
|---|------|
| 1 | `features/webview.feature` — Gherkin file matching the scenarios above |
| 2 | `steps/WebviewSteps.java` — Step definitions for all Webview steps |
| 3 | `pages/WebviewPage.java` — Page Object with all locators and actions |
| 4 | All scenarios passing with `mvn test -Dcucumber.filter.tags="@webview"` |
