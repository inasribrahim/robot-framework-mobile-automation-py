# Android Automation Task – Java / Cucumber / TestNG / Allure

> **Automation task & deliverables for QA Automation Engineers (Junior & Senior)**
>
> **Stack:** Java 11 · Cucumber 7 (BDD) · TestNG · Allure 2 · Appium 2 (UIAutomator2)
> **Platform:** Android only

---

## Deliverables

| # | Deliverable | Location |
|---|-------------|----------|
| 1 | **Repo** – project structure + Maven config | `java-cucumber-android/` |
| 2 | **Test Scenarios** – BDD feature files | `src/test/resources/features/` |
| 3 | **Demo** – run locally & view Allure report | [Quick Start](#quick-start) |
| 4 | **Pipeline bones** *(Senior)* | `.github/workflows/android-java-cucumber-allure.yml` |

---

## The Task

Automate the **WDIO Native Demo App** (`apps/wdioNativeDemoApp.apk`) on Android.

### Screens to automate

| Screen | Package / Activity |
|--------|--------------------|
| Login  | `com.wdiodemoapp / .MainActivity` |
| Sign Up | navigated from Login |

### What to build

```
Given a BDD scenario written in Gherkin (feature file)
→  write a step definition class that maps each step to a method
→  write a page object class that encapsulates all driver calls for that screen
→  run with TestNG via mvn test
→  view results in Allure report
```

---

## Test Scenarios

### Login (`features/login/login.feature`)

| # | Scenario | Tag | Priority |
|---|----------|-----|----------|
| 1 | Successful login with valid credentials | `@smoke` | `@P0` |
| 2 | Invalid email format shows an error | `@smoke` | `@P1` |
| 3 | Password shorter than 8 chars shows an error | `@smoke` | `@P1` |
| 4 | Navigate from Login to Sign Up screen | `@smoke` | `@P2` |
| 5 | Data-driven: multiple invalid inputs (Scenario Outline) | `@smoke` | `@P1` |

### Sign Up (`features/signup/signup.feature`)

| # | Scenario | Tag | Priority |
|---|----------|-----|----------|
| 1 | Successful registration with valid details | `@smoke` | `@P0` |
| 2 | Invalid email format shows an error | `@smoke` | `@P1` |
| 3 | Mismatched passwords show a confirm-password error | `@smoke` | `@P1` |
| 4 | Short password shows a password error | `@smoke` | `@P1` |

---

## Project Structure

```
java-cucumber-android/
├── src/
│   ├── main/java/com/automation/
│   │   ├── config/CapabilitiesConfig.java   ← Appium capabilities
│   │   ├── driver/DriverManager.java         ← ThreadLocal driver
│   │   └── pages/
│   │       ├── BasePage.java                 ← Shared wait helpers
│   │       ├── LoginPage.java                ← Login screen POM
│   │       └── SignupPage.java               ← Sign-Up screen POM
│   └── test/
│       ├── java/com/automation/
│       │   ├── hooks/Hooks.java              ← @Before/@After + screenshot
│       │   ├── runners/TestRunner.java        ← TestNG + Cucumber + Allure
│       │   └── steps/
│       │       ├── LoginSteps.java            ← Login step definitions
│       │       └── SignupSteps.java           ← Sign-Up step definitions
│       └── resources/
│           ├── features/
│           │   ├── login/login.feature        ← ✅ Provided
│           │   └── signup/signup.feature      ← ✅ Provided
│           ├── config.properties              ← Device settings
│           └── allure.properties              ← Report output path
├── pom.xml                                    ← Dependencies
└── testng.xml                                 ← Suite definition
```

> **Feature files are provided.** Everything else (step definitions, page objects, hooks, runner) is what you implement.

---

## Quick Start

### Prerequisites

| Tool | Version | How to install |
|------|---------|----------------|
| Java JDK | 11+ | [adoptium.net](https://adoptium.net/) |
| Maven | 3.8+ | [maven.apache.org](https://maven.apache.org/install.html) |
| Node.js | 18+ | [nodejs.org](https://nodejs.org/) |
| Appium CLI | 2.x | `npm install -g appium@latest` |
| UIAutomator2 | latest | `appium driver install uiautomator2` |
| Android Studio | latest | [developer.android.com/studio](https://developer.android.com/studio) |

### Run

```bash
# 1 – Start an Android emulator (API 33 recommended) from Android Studio
# 2 – Start Appium
appium

# 3 – Run all tests
cd java-cucumber-android
mvn test

# 4 – Generate + open Allure report
mvn allure:report
open target/site/allure-maven-plugin/index.html
```

### Run by tag

```bash
mvn test -Dcucumber.filter.tags="@smoke"      # smoke suite
mvn test -Dcucumber.filter.tags="@P0"         # critical only
mvn test -Dcucumber.filter.tags="@login"      # login module
```

---

## CI/CD Pipeline (Senior)

File: `.github/workflows/android-java-cucumber-allure.yml`

```
Checkout → Java 11 → Node 20 → Appium 2 + UIAutomator2
  → Enable KVM → Start Appium → Android Emulator (API 33)
    → mvn test → mvn allure:report
      → Upload: allure-report · allure-results · appium-log
```

**Trigger:** push / PR to `main` touching `java-cucumber-android/**`, or manually via **Actions → Run workflow**.

**Artifacts** (download from the workflow run):

| Artifact | Contents |
|----------|----------|
| `allure-report` | Full Allure HTML – open `index.html` |
| `allure-results` | Raw JSON for trend history |
| `appium-log` | Appium server output |
