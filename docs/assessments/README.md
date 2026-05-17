<p align="center">
  <img src="https://www.cibeg.com/-/media/feature/navigation/footer/logo-white.svg"
       alt="CIB Bank Logo" width="260" style="background:#003366; padding:16px; border-radius:8px;" />
</p>

<h1 align="center">QA Automation Assessment</h1>
<p align="center"><strong>Commercial International Bank — Mobile Automation Track</strong></p>

---

> **📋 This assessment has been assigned to you.**
> Work through each module below in order. Every module contains a user story, acceptance criteria, and Gherkin scenarios to implement.
> **Assessment issued by: CIB — Commercial International Bank**

---

## How This Assessment Works

Each of the 10 modules below follows the same structure:

```
User Story
  └── Acceptance Criteria  (the conditions that define "done")
        └── Gherkin Scenarios  (the test cases you must automate)
```

You are expected to:
1. Read the **user story** and understand *who* needs the feature and *why*.
2. Understand each **acceptance criterion** — these become your test oracle.
3. Implement the **Gherkin scenarios** in `.feature` files, `StepDefs`, and `PageObjects`.
4. Ensure every scenario passes when you run `mvn test`.

---

## Assessment Modules

| # | Module | Screen / Feature | P0 Scenarios | File |
|---|--------|-----------------|--------------|------|
| 01 | Navigation Bar | Bottom tab bar | — | [01-navigation-bar.md](./01-navigation-bar.md) |
| 02 | Home Screen | Landing screen | H-01 | [02-home-screen.md](./02-home-screen.md) |
| 03 | Webview Screen | Embedded browser | — | [03-webview-screen.md](./03-webview-screen.md) |
| 04 | Login — Happy Path | Valid login flow | L-01 | [04-login-happy-path.md](./04-login-happy-path.md) |
| 05 | Login — Validation | Error messages | — | [05-login-validation.md](./05-login-validation.md) |
| 06 | Sign Up — Happy Path | Valid registration | S-01 | [06-signup-happy-path.md](./06-signup-happy-path.md) |
| 07 | Sign Up — Validation | Error messages | — | [07-signup-validation.md](./07-signup-validation.md) |
| 08 | Forms Screen | Text, toggle, dropdown, slider | — | [08-forms-screen.md](./08-forms-screen.md) |
| 09 | Swipe Screen | Gestures & drag-drop | — | [09-swipe-screen.md](./09-swipe-screen.md) |
| 10 | End-to-End Flow | Full user journey | E2E-01 | [10-end-to-end-flow.md](./10-end-to-end-flow.md) |

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
| App under test | WDIO Native Demo App (Android) |

---

## Scenario Priority Guide

| Priority | Meaning | CI Required |
|----------|---------|-------------|
| P0 | Critical — must pass before any release | ✅ Yes |
| P1 | High — should pass; blocks release if failed | recommended |
| P2 | Medium — improves confidence; not blocking | optional |

---

## Quick Start

```bash
# Prerequisites: Java 11, Maven, Node.js, Android emulator running

appium                                             # start Appium server

mvn test                                           # run all scenarios
mvn test -Dcucumber.filter.tags="@smoke"           # smoke (P0) only
mvn test -Dcucumber.filter.tags="@e2e"             # end-to-end only
mvn allure:report                                  # generate HTML report
open target/site/allure-maven-plugin/index.html
```

---

## Deliverables Checklist

### Junior Engineer

- [ ] All 10 module feature files written in valid Gherkin
- [ ] Step definitions wired — no undefined steps
- [ ] Page Object Model applied — no driver calls inside step definitions
- [ ] Tests execute with `mvn test`
- [ ] Allure report generated and shows pass/fail per scenario

### Senior Engineer

All junior items, plus:

- [ ] `DriverManager` uses `ThreadLocal<AppiumDriver>` for parallel-safe access
- [ ] Screenshot automatically captured on scenario failure and attached to Allure
- [ ] `@Before` / `@After` hooks manage driver lifecycle (no leaks)
- [ ] GitHub Actions pipeline runs on push and pull request
- [ ] Pipeline uploads Allure HTML report as a downloadable artifact
- [ ] All P0 scenarios pass in CI without manual intervention
- [ ] Locator strategy choices justified (accessibility_id vs id vs XPath)

---

*Assessment prepared and issued by the CIB QA Engineering team.*
