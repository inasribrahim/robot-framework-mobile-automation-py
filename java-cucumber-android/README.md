# Android Automation Task Assessment
## Java · Cucumber · TestNG · Allure

> This document is the complete task brief for QA Automation Engineers (Junior & Senior).
> Read it fully before starting. Your deliverables are listed at the bottom.

---

## App Under Test

**WDIO Native Demo App** – Android only (`apps/wdioNativeDemoApp.apk` in this repo)

The app has **5 screens** accessible from a bottom navigation bar, plus a **Sign Up** screen reachable from Login.

| Screen | Description |
|--------|-------------|
| Home | Landing / welcome screen |
| Webview | Embedded browser with an address bar |
| Login | Email + password authentication |
| Sign Up | New user registration |
| Forms | Input controls (text field, toggle, dropdown, slider) |
| Swipe | Swipeable cards + drag-and-drop area |

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Language | Java 11 |
| Build | Maven |
| BDD | Cucumber 7 (Gherkin) |
| Runner | TestNG |
| Mobile driver | Appium 2 + UIAutomator2 |
| Reporting | Allure 2 |

---

## Test Scenarios

Implement **all** of the following scenarios using the BDD pattern (`Given / When / Then`).

---

### 1 · Navigation Bar

| # | Scenario | Priority |
|---|----------|----------|
| N-01 | All 5 navigation tabs are visible on app launch | P1 |
| N-02 | Tapping the Home tab displays the Home screen | P1 |
| N-03 | Tapping the Webview tab displays the Webview screen | P1 |
| N-04 | Tapping the Login tab displays the Login screen | P1 |
| N-05 | Tapping the Forms tab displays the Forms screen | P1 |
| N-06 | Tapping the Swipe tab displays the Swipe screen | P1 |
| N-07 | The active tab is visually highlighted | P2 |

---

### 2 · Home Screen

| # | Scenario | Priority |
|---|----------|----------|
| H-01 | Home screen is displayed when the app launches | P0 |
| H-02 | App logo / title is visible on the Home screen | P2 |
| H-03 | Navigating away and back shows the Home screen again | P2 |

---

### 3 · Webview Screen

| # | Scenario | Priority |
|---|----------|----------|
| W-01 | Webview screen is displayed | P1 |
| W-02 | The default URL is loaded in the webview | P1 |
| W-03 | User can type a URL in the address bar and navigate | P1 |
| W-04 | Webview renders page content | P2 |
| W-05 | Navigating back returns to the Webview screen | P2 |

---

### 4 · Login Screen

| # | Scenario | Priority |
|---|----------|----------|
| L-01 | Successful login with valid credentials shows a success alert | P0 |
| L-02 | Invalid email format shows an email validation error | P1 |
| L-03 | Password shorter than 8 characters shows a password validation error | P1 |
| L-04 | Submitting with an empty email field shows a validation error | P1 |
| L-05 | Submitting with an empty password field shows a validation error | P1 |
| L-06 | Submitting with both fields empty shows validation errors | P2 |
| L-07 | All Login screen elements (fields, button) are visible | P2 |
| L-08 | Tapping the Sign Up link navigates to the Sign Up screen | P2 |
| L-09 | Clearing the form resets both fields to empty | P2 |
| L-10 | Login with a password containing special characters succeeds | P1 |
| L-11 | Dismissing the success alert returns to the Login screen | P2 |
| L-12 | Login session persists after the app is backgrounded and reactivated | P2 |
| L-13 | Three consecutive failed attempts each show a validation error | P2 |
| L-14 | Login with a very long email address | P2 |
| L-15 | Password field masks its input | P2 |

---

### 5 · Sign Up Screen

| # | Scenario | Priority |
|---|----------|----------|
| S-01 | Successful sign-up with valid details shows a success alert | P0 |
| S-02 | Invalid email format shows an email validation error | P1 |
| S-03 | Password shorter than 8 characters shows a password validation error | P1 |
| S-04 | Mismatched passwords show a confirm-password error | P1 |
| S-05 | Submitting with an empty email field shows a validation error | P1 |
| S-06 | Submitting with an empty password field shows a validation error | P1 |
| S-07 | Submitting with an empty confirm-password field shows a validation error | P1 |
| S-08 | All Sign Up screen elements are visible | P2 |
| S-09 | Tapping the Login link navigates back to the Login screen | P2 |
| S-10 | Clearing the form resets all fields | P2 |
| S-11 | Sign-up with a password containing special characters succeeds | P1 |
| S-12 | Dismissing the success alert stays on the screen | P2 |
| S-13 | Sign-up with a very long email address | P2 |
| S-14 | Both password fields mask their input | P2 |
| S-15 | Attempting to sign up with an already-registered email | P1 |
| S-16 | Two consecutive sign-up attempts with the same email | P2 |
| S-17 | Inline validation triggers when leaving the email field | P2 |
| S-18 | Sign-up with exactly 8-character password (boundary) | P1 |
| S-19 | Sign-up with an upper-case email address | P2 |
| S-20 | Full sign-up flow completes within 30 seconds | P2 |

---

### 6 · Forms Screen

| # | Scenario | Priority |
|---|----------|----------|
| F-01 | Forms screen is displayed | P1 |
| F-02 | User can type text into the text input | P1 |
| F-03 | Clearing the text input empties the field | P1 |
| F-04 | Toggle switch changes state from OFF to ON | P1 |
| F-05 | Toggle switch changes state from ON to OFF | P1 |
| F-06 | User can select an option from the dropdown | P1 |
| F-07 | Slider can be moved to a new position | P2 |
| F-08 | Active / inactive control changes its state | P2 |

---

### 7 · Swipe Screen

| # | Scenario | Priority |
|---|----------|----------|
| SW-01 | Swipe screen is displayed with cards visible | P1 |
| SW-02 | Swiping a card to the left removes it or reveals content | P1 |
| SW-03 | Swiping a card to the right removes it or reveals content | P1 |
| SW-04 | Dragging an element to the drop zone triggers success feedback | P1 |
| SW-05 | All swipe cards are accessible by swiping through the list | P2 |

---

## Project Structure to Implement

```
java-cucumber-android/
├── src/
│   ├── main/java/com/automation/
│   │   ├── config/          ← Appium capabilities
│   │   ├── driver/          ← ThreadLocal driver manager
│   │   └── pages/           ← Page Objects (one class per screen)
│   └── test/
│       ├── java/com/automation/
│       │   ├── hooks/       ← @Before / @After (driver + screenshot on fail)
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

## Deliverables

| # | Deliverable | Who |
|---|-------------|-----|
| 1 | This repo forked with your implementation | All |
| 2 | All scenarios above implemented and passing locally | All |
| 3 | Demo recording (screen capture of a test run + Allure report) | All |
| 4 | GitHub Actions pipeline that runs the tests on an Android emulator | Senior |

---

## Evaluation Criteria

### Junior

- Feature files written in valid Gherkin
- Step definitions wired correctly (no undefined steps)
- Page Object Model applied (no driver calls inside step definitions)
- Tests can be executed with `mvn test`
- Basic Allure report generated

### Senior

All of the above, plus:

- `DriverManager` uses `ThreadLocal` for parallel-safe driver access
- Screenshot captured automatically on scenario failure and attached to Allure
- GitHub Actions pipeline (`.github/workflows/`) runs on push / PR
- Pipeline uploads Allure HTML report and raw results as artifacts
- At least the P0 scenarios run in CI without manual steps

---

## How to Run (reference)

```bash
# Prerequisites: Java 11, Maven, Node.js, Android emulator running, Appium started

# Run all tests
mvn test

# Run smoke suite only
mvn test -Dcucumber.filter.tags="@smoke"

# Generate Allure report
mvn allure:report
open target/site/allure-maven-plugin/index.html
```

