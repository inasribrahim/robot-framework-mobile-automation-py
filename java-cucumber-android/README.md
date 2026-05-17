# Android Automation Task Assessment
## Java · Cucumber · TestNG · Allure

> **For QA Automation Engineers — Junior & Senior**
>
> This document follows the standard QA workflow:
> **User Stories → Acceptance Criteria → Test Scenarios → Automation Assessment**
>
> Read each section in order. The automation task is at the bottom.

---

## App Under Test

**WDIO Native Demo App** — Android only (`apps/wdioNativeDemoApp.apk`)

The app contains **6 screens** accessible from a bottom navigation bar (Home, Webview, Login, Forms, Swipe) plus a **Sign Up** screen reachable from Login.

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Language | Java 11 |
| Build tool | Maven |
| BDD framework | Cucumber 7 (Gherkin) |
| Test runner | TestNG |
| Mobile driver | Appium 2 + UIAutomator2 |
| Reporting | Allure 2 |

---

---

# Part 1 — User Stories & Acceptance Criteria

> User stories describe **who** wants **what** and **why**.
> Acceptance criteria define the **conditions** that must be true for the story to be considered done.
> Test scenarios are then derived directly from those criteria.

---

## US-01 · App Navigation

**As a** user,
**I want** to navigate between the app's main screens using the bottom navigation bar,
**so that** I can quickly access any section of the app.

### Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-01.1 | The navigation bar shows exactly 5 tabs: Home, Webview, Login, Forms, Swipe |
| AC-01.2 | Tapping any tab navigates to the corresponding screen |
| AC-01.3 | The currently active tab is visually distinguished from inactive tabs |
| AC-01.4 | Navigating to a tab and returning to a previous tab restores that screen |

---

## US-02 · Home Screen

**As a** user,
**I want** to see a welcome screen when I open the app,
**so that** I have a clear starting point before navigating elsewhere.

### Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-02.1 | The Home screen is the first screen displayed on app launch |
| AC-02.2 | The app logo and title are visible on the Home screen |
| AC-02.3 | The Home screen is restored when the user navigates away and returns |

---

## US-03 · Webview Screen

**As a** user,
**I want** to view web content inside the app,
**so that** I can browse URLs without leaving the application.

### Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-03.1 | The Webview screen is displayed when the Webview tab is tapped |
| AC-03.2 | A default URL is pre-loaded in the webview on screen open |
| AC-03.3 | The user can type a custom URL into the address bar and load it |
| AC-03.4 | The webview renders page content (not a blank or error page) |
| AC-03.5 | Navigating back from a loaded page keeps the user on the Webview screen |

---

## US-04 · User Login

**As a** registered user,
**I want** to log in with my email and password,
**so that** I can access my account.

### Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-04.1 | Entering a valid email and password and tapping Login shows a success alert |
| AC-04.2 | The email field validates format — an invalid format shows an error message |
| AC-04.3 | The password field requires a minimum of 8 characters — a shorter value shows an error |
| AC-04.4 | Submitting with an empty email field shows an email validation error |
| AC-04.5 | Submitting with an empty password field shows a password validation error |
| AC-04.6 | Submitting with both fields empty shows both validation errors |
| AC-04.7 | All required screen elements (email field, password field, Login button) are visible |
| AC-04.8 | A link to the Sign Up screen is available and navigates correctly |
| AC-04.9 | The password field masks its characters for security |
| AC-04.10 | Passwords containing special characters are accepted |
| AC-04.11 | Dismissing the success alert returns the user to the Login screen |
| AC-04.12 | Login state persists when the app is backgrounded and reactivated |

---

## US-05 · User Sign Up

**As a** new user,
**I want** to create an account with my email and a chosen password,
**so that** I can start using the app.

### Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-05.1 | Providing a valid email, matching passwords ≥ 8 characters shows a success alert |
| AC-05.2 | The email field validates format — an invalid format shows an error message |
| AC-05.3 | The password field requires a minimum of 8 characters |
| AC-05.4 | The password and confirm-password fields must match — a mismatch shows an error |
| AC-05.5 | Submitting with an empty email field shows a validation error |
| AC-05.6 | Submitting with an empty password field shows a validation error |
| AC-05.7 | Submitting with an empty confirm-password field shows a validation error |
| AC-05.8 | All required screen elements are visible |
| AC-05.9 | A link to the Login screen is available and navigates correctly |
| AC-05.10 | Both password fields mask their characters |
| AC-05.11 | Passwords containing special characters are accepted |
| AC-05.12 | A password of exactly 8 characters (boundary value) is accepted |
| AC-05.13 | Inline validation triggers when the user leaves the email field |
| AC-05.14 | Attempting sign-up with an already-registered email is handled with appropriate feedback |

---

## US-06 · Forms Screen

**As a** user,
**I want** to interact with form controls (text input, toggle, dropdown, slider),
**so that** I can submit or adjust settings within the app.

### Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-06.1 | The Forms screen is displayed when the Forms tab is tapped |
| AC-06.2 | The user can type text into the text input field |
| AC-06.3 | Clearing the text input empties the field |
| AC-06.4 | The toggle switch can be switched from OFF to ON |
| AC-06.5 | The toggle switch can be switched from ON to OFF |
| AC-06.6 | The user can select an option from the dropdown |
| AC-06.7 | The slider can be dragged to a new position |
| AC-06.8 | Controls that can be enabled/disabled change state correctly |

---

## US-07 · Swipe Screen

**As a** user,
**I want** to swipe through cards and drag elements into a drop zone,
**so that** I can interact with gesture-based UI components.

### Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-07.1 | The Swipe screen is displayed when the Swipe tab is tapped |
| AC-07.2 | Swiping a card to the left removes it from view or reveals underlying content |
| AC-07.3 | Swiping a card to the right removes it from view or reveals underlying content |
| AC-07.4 | Dragging an element to the correct drop zone shows a success indicator |
| AC-07.5 | All cards in the list are reachable by swiping vertically through the stack |

---

---

# Part 2 — Test Scenarios

> Each scenario is derived from the acceptance criteria above.
> The `AC` reference shows which criterion the scenario validates.

---

## Navigation Bar Scenarios

| ID | Scenario | AC Ref | Priority |
|----|----------|--------|----------|
| N-01 | App launches and all 5 navigation tabs are visible | AC-01.1 | P1 |
| N-02 | Tapping Home tab displays the Home screen | AC-01.2 | P1 |
| N-03 | Tapping Webview tab displays the Webview screen | AC-01.2 | P1 |
| N-04 | Tapping Login tab displays the Login screen | AC-01.2 | P1 |
| N-05 | Tapping Forms tab displays the Forms screen | AC-01.2 | P1 |
| N-06 | Tapping Swipe tab displays the Swipe screen | AC-01.2 | P1 |
| N-07 | The active tab is visually highlighted | AC-01.3 | P2 |
| N-08 | Navigate away from Home and back — Home screen is restored | AC-01.4 | P2 |

---

## Home Screen Scenarios

| ID | Scenario | AC Ref | Priority |
|----|----------|--------|----------|
| H-01 | Home screen is the first screen shown on app launch | AC-02.1 | P0 |
| H-02 | App logo and title are visible on the Home screen | AC-02.2 | P2 |
| H-03 | Navigate to another tab and back — Home screen is displayed again | AC-02.3 | P2 |

---

## Webview Screen Scenarios

| ID | Scenario | AC Ref | Priority |
|----|----------|--------|----------|
| W-01 | Webview screen is displayed when the Webview tab is tapped | AC-03.1 | P1 |
| W-02 | A default URL is pre-loaded when the Webview screen opens | AC-03.2 | P1 |
| W-03 | User types a URL in the address bar and the page loads | AC-03.3 | P1 |
| W-04 | Page content is rendered (not blank or error) | AC-03.4 | P2 |
| W-05 | Navigating back from a loaded page stays on the Webview screen | AC-03.5 | P2 |

---

## Login Screen Scenarios

| ID | Scenario | AC Ref | Priority |
|----|----------|--------|----------|
| L-01 | Successful login with valid email and password shows a success alert | AC-04.1 | P0 |
| L-02 | Invalid email format shows an email validation error | AC-04.2 | P1 |
| L-03 | Password shorter than 8 characters shows a password validation error | AC-04.3 | P1 |
| L-04 | Submitting with an empty email field shows a validation error | AC-04.4 | P1 |
| L-05 | Submitting with an empty password field shows a validation error | AC-04.5 | P1 |
| L-06 | Submitting with both fields empty shows validation errors | AC-04.6 | P2 |
| L-07 | Email field, password field and Login button are all visible | AC-04.7 | P2 |
| L-08 | Tapping the Sign Up link navigates to the Sign Up screen | AC-04.8 | P2 |
| L-09 | Password field masks its characters | AC-04.9 | P2 |
| L-10 | Login with a password containing special characters succeeds | AC-04.10 | P1 |
| L-11 | Dismissing the success alert returns to the Login screen | AC-04.11 | P2 |
| L-12 | Login state persists after the app is backgrounded and reactivated | AC-04.12 | P2 |
| L-13 | Three consecutive invalid-email attempts each show a validation error | AC-04.2 | P2 |
| L-14 | Login with a very long (boundary) email address | AC-04.1 | P2 |
| L-15 | Clearing the form resets both fields to empty | AC-04.7 | P2 |

---

## Sign Up Screen Scenarios

| ID | Scenario | AC Ref | Priority |
|----|----------|--------|----------|
| S-01 | Successful sign-up with valid email and matching passwords shows a success alert | AC-05.1 | P0 |
| S-02 | Invalid email format shows an email validation error | AC-05.2 | P1 |
| S-03 | Password shorter than 8 characters shows a password validation error | AC-05.3 | P1 |
| S-04 | Mismatched passwords show a confirm-password error | AC-05.4 | P1 |
| S-05 | Submitting with an empty email field shows a validation error | AC-05.5 | P1 |
| S-06 | Submitting with an empty password field shows a validation error | AC-05.6 | P1 |
| S-07 | Submitting with an empty confirm-password field shows a validation error | AC-05.7 | P1 |
| S-08 | All Sign Up screen elements are visible | AC-05.8 | P2 |
| S-09 | Tapping the Login link navigates back to the Login screen | AC-05.9 | P2 |
| S-10 | Both password fields mask their characters | AC-05.10 | P2 |
| S-11 | Sign-up with a password containing special characters succeeds | AC-05.11 | P1 |
| S-12 | Sign-up with exactly 8-character password (boundary value) succeeds | AC-05.12 | P1 |
| S-13 | Inline validation triggers when leaving the email field | AC-05.13 | P2 |
| S-14 | Attempting sign-up with an already-registered email shows appropriate feedback | AC-05.14 | P1 |
| S-15 | Two consecutive sign-up attempts with the same email | AC-05.14 | P2 |
| S-16 | Clearing the form resets all three fields | AC-05.8 | P2 |
| S-17 | Dismissing the success alert stays on / returns to the correct screen | AC-05.1 | P2 |
| S-18 | Sign-up with a very long email address | AC-05.1 | P2 |
| S-19 | Sign-up with an upper-case email address | AC-05.1 | P2 |
| S-20 | Full sign-up flow completes within 30 seconds | AC-05.1 | P2 |

---

## Forms Screen Scenarios

| ID | Scenario | AC Ref | Priority |
|----|----------|--------|----------|
| F-01 | Forms screen is displayed when the Forms tab is tapped | AC-06.1 | P1 |
| F-02 | User can type text into the text input field | AC-06.2 | P1 |
| F-03 | Clearing the text input empties the field | AC-06.3 | P1 |
| F-04 | Toggle switch changes from OFF to ON | AC-06.4 | P1 |
| F-05 | Toggle switch changes from ON to OFF | AC-06.5 | P1 |
| F-06 | User can select an option from the dropdown | AC-06.6 | P1 |
| F-07 | Slider can be dragged to a new position | AC-06.7 | P2 |
| F-08 | Enable/disable control toggles its state correctly | AC-06.8 | P2 |

---

## Swipe Screen Scenarios

| ID | Scenario | AC Ref | Priority |
|----|----------|--------|----------|
| SW-01 | Swipe screen is displayed with cards visible | AC-07.1 | P1 |
| SW-02 | Swiping a card left removes it or reveals content | AC-07.2 | P1 |
| SW-03 | Swiping a card right removes it or reveals content | AC-07.3 | P1 |
| SW-04 | Dragging an element to the drop zone shows a success indicator | AC-07.4 | P1 |
| SW-05 | All cards are reachable by swiping through the stack | AC-07.5 | P2 |

---

---

# Part 3 — Automation Assessment

> Your task is to automate the scenarios in Part 2 using the tech stack below.
> Each scenario maps to a Gherkin feature file, a step definition class, and a page object.

---

## Recommended Project Structure

```
java-cucumber-android/
├── src/
│   ├── main/java/com/automation/
│   │   ├── config/          ← Appium desired capabilities
│   │   ├── driver/          ← ThreadLocal driver manager
│   │   └── pages/           ← Page Objects (one class per screen)
│   └── test/
│       ├── java/com/automation/
│       │   ├── hooks/       ← @Before / @After + screenshot on failure
│       │   ├── runners/     ← TestNG + Cucumber entry point
│       │   └── steps/       ← Step definitions (one class per screen)
│       └── resources/
│           ├── features/    ← .feature files (one per screen)
│           ├── config.properties
│           └── allure.properties
├── pom.xml
└── testng.xml
```

---

## How to Run (reference)

```bash
# Prerequisites: Java 11, Maven, Node.js, Android emulator running, Appium started

appium                                          # start Appium server
mvn test                                        # run all scenarios
mvn test -Dcucumber.filter.tags="@smoke"        # smoke only
mvn allure:report                               # generate Allure HTML
open target/site/allure-maven-plugin/index.html
```

---

## Deliverables

| # | Deliverable | Who |
|---|-------------|-----|
| 1 | Forked repo with your full implementation | All |
| 2 | All scenarios from Part 2 automated and passing locally | All |
| 3 | Demo recording — test run + Allure report walkthrough | All |
| 4 | GitHub Actions pipeline running tests on an Android emulator | Senior |

---

## Evaluation Criteria

### Junior Engineer

- [ ] User stories and acceptance criteria understood (can explain each AC)
- [ ] Feature files written in valid Gherkin with correct `Given / When / Then` syntax
- [ ] Each scenario traces back to an acceptance criterion
- [ ] Step definitions wired with no undefined steps
- [ ] Page Object Model applied — no Appium/Selenium driver calls inside step definitions
- [ ] Tests execute successfully with `mvn test`
- [ ] Allure report generated and shows pass/fail results

### Senior Engineer

All junior criteria, plus:

- [ ] `DriverManager` uses `ThreadLocal<AppiumDriver>` for parallel-safe driver access
- [ ] Screenshot captured automatically on scenario failure and attached to Allure
- [ ] `@Before` / `@After` hooks manage driver lifecycle cleanly (no leaks)
- [ ] GitHub Actions pipeline (`.github/workflows/`) runs on push and pull request
- [ ] Pipeline uploads the Allure HTML report and raw results as downloadable artifacts
- [ ] P0 scenarios execute in CI without any manual steps
- [ ] Can justify locator strategy choices (accessibility_id vs id vs XPath)

