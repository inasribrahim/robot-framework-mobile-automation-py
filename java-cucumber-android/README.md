# Java Cucumber Android Automation Framework

> **A production-ready Android mobile test automation framework built with Java, Cucumber BDD, TestNG, and Allure reporting.**
>
> Designed as a learning reference and starting point for both **junior** and **senior** QA automation engineers.

---

## Table of Contents

- [About This Project](#about-this-project)
- [Tech Stack Explained](#tech-stack-explained)
- [Framework Architecture](#framework-architecture)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Configuration](#configuration)
- [Writing Tests](#writing-tests)
- [Running Tests](#running-tests)
- [Allure Reports](#allure-reports)
- [Tagging Strategy](#tagging-strategy)
- [Best Practices](#best-practices)
- [Advanced Topics (Senior)](#advanced-topics-senior)
- [CI/CD Pipeline](#cicd-pipeline)
- [Troubleshooting](#troubleshooting)

---

## About This Project

This framework automates the **WDIO Native Demo App** on Android using a widely adopted industry stack.  
It covers Login and Sign-Up flows and is intentionally kept **simple enough for juniors** while applying patterns (Page Object Model, ThreadLocal driver management, Allure hooks) that **seniors will recognise and want to extend**.

### App Under Test

| Property | Value |
|---|---|
| APK | `apps/wdioNativeDemoApp.apk` |
| Package | `com.wdiodemoapp` |
| Screens covered | Login, Sign-Up |

---

## Tech Stack Explained

> *New to the stack? Start here.*

### Java 11

The core programming language. Java is statically typed, object-oriented, and the most common language in enterprise test automation.  
[▶ Official docs](https://docs.oracle.com/en/java/javase/11/)

### Apache Maven

Build tool and dependency manager. `pom.xml` lists all third-party libraries; Maven downloads them automatically.  
```
mvn test          # compile + run tests
mvn allure:report # generate HTML report
```
[▶ Official docs](https://maven.apache.org/)

### Appium 2 + UIAutomator2

Appium is an open-source framework for automating mobile apps. It starts a local server that accepts WebDriver commands and translates them into native Android actions via the **UIAutomator2** driver.

```
┌────────────┐  WebDriver  ┌────────────┐  UIAutomator2  ┌─────────────┐
│ Java Test  │────────────▶│ Appium 2   │───────────────▶│ Android App │
└────────────┘             └────────────┘                └─────────────┘
```
[▶ Appium docs](https://appium.io/docs/en/2.0/)

### Cucumber 7 (BDD)

Cucumber lets you write test scenarios in plain English using the **Gherkin** syntax (`Given / When / Then`).  
This bridges the gap between business requirements and automated tests.

```gherkin
Scenario: Successful login
  Given the user is on the login screen
  When  the user logs in with email "alice@example.com" and password "Secret123!"
  Then  the login success alert should be displayed
```

Each step maps to a Java method annotated with `@Given`, `@When`, or `@Then`.  
[▶ Cucumber docs](https://cucumber.io/docs/cucumber/)

### TestNG

TestNG is the test runner. It discovers and runs `TestRunner.java` (which extends `AbstractTestNGCucumberTests`) and provides features like parallel execution, listeners, and retry logic.  
[▶ TestNG docs](https://testng.org/)

### Allure 2

Allure generates a beautiful, interactive HTML test report that includes:
- Pass / fail / skip counts with drill-down
- Step-by-step scenario timeline
- Screenshots embedded on failure
- Trend graphs across multiple runs (when used with CI history)

[▶ Allure docs](https://allurereport.org/docs/)

---

## Framework Architecture

```
java-cucumber-android/
│
├── src/main/java/com/automation/
│   ├── config/
│   │   └── CapabilitiesConfig.java    ← Appium desired capabilities
│   ├── driver/
│   │   └── DriverManager.java         ← ThreadLocal driver lifecycle
│   └── pages/
│       ├── BasePage.java              ← Shared driver + wait helpers
│       ├── LoginPage.java             ← Login screen interactions
│       └── SignupPage.java            ← Sign-Up screen interactions
│
├── src/test/java/com/automation/
│   ├── hooks/
│   │   └── Hooks.java                 ← @Before / @After (driver + screenshots)
│   ├── runners/
│   │   └── TestRunner.java            ← TestNG + Cucumber entry point
│   └── steps/
│       ├── LoginSteps.java            ← Gherkin → Java (Login)
│       └── SignupSteps.java           ← Gherkin → Java (Sign-Up)
│
├── src/test/resources/
│   ├── features/
│   │   ├── login/login.feature        ← BDD scenarios (Login)
│   │   └── signup/signup.feature      ← BDD scenarios (Sign-Up)
│   ├── config.properties              ← Device & app settings
│   ├── allure.properties              ← Allure output directory
│   └── logback-test.xml               ← Console logging config
│
├── pom.xml                            ← Maven dependencies + plugins
├── testng.xml                         ← TestNG suite definition
└── README.md                          ← This file
```

### Design Patterns Used

| Pattern | Where | Why |
|---|---|---|
| **Page Object Model (POM)** | `pages/` | Separates UI interactions from test logic |
| **ThreadLocal Driver** | `DriverManager` | Enables future parallel execution safely |
| **Factory / Builder** | `CapabilitiesConfig` | Centralises capability construction |
| **Fluent Interface** | `LoginPage`, `SignupPage` | Readable chained calls |

---

## Prerequisites

| Tool | Version | Install |
|---|---|---|
| Java JDK | 11+ | [adoptium.net](https://adoptium.net/) |
| Apache Maven | 3.8+ | [maven.apache.org](https://maven.apache.org/install.html) |
| Node.js | 18+ | [nodejs.org](https://nodejs.org/) |
| Appium CLI | 2.x | `npm install -g appium@latest` |
| UIAutomator2 driver | latest | `appium driver install uiautomator2` |
| Android Studio | latest | [developer.android.com/studio](https://developer.android.com/studio) |
| Allure CLI (optional) | 2.x | [allurereport.org](https://allurereport.org/docs/install/) |

### Environment Variables

```bash
export ANDROID_HOME=$HOME/Library/Android/sdk       # macOS
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

---

## Quick Start

### 1 – Clone the repo

```bash
git clone https://github.com/inasribrahim/robot-framework-mobile-automation-py.git
cd robot-framework-mobile-automation-py/java-cucumber-android
```

### 2 – Install Maven dependencies

```bash
mvn dependency:resolve
```

### 3 – Create an Android Virtual Device (AVD)

Open **Android Studio → Device Manager → Create Virtual Device**.  
Recommended: **Pixel 6**, API 33 (Android 13), x86_64.

### 4 – Start the emulator

```bash
emulator -avd Pixel_6_API_33
# or via Android Studio's Device Manager
```

### 5 – Start Appium server

```bash
appium --log-level info
```

### 6 – Run all tests

```bash
mvn test
```

### 7 – View Allure report

```bash
mvn allure:report
open target/site/allure-maven-plugin/index.html
```

---

## Project Structure

### Feature Files (for Juniors)

Feature files live in `src/test/resources/features/` and use the **Gherkin** language.

```gherkin
Feature: Login Functionality

  Scenario: Successful login
    Given the user is on the login screen
    When  the user logs in with email "alice@example.com" and password "Secret123!"
    Then  the login success alert should be displayed
```

**Rules:**
- One `.feature` file per screen / module
- Use `Background` for steps shared by all scenarios in a file
- Use `Scenario Outline` + `Examples` for data-driven tests

### Step Definitions (for Juniors)

Each Gherkin step maps to a Java method:

```java
@When("the user logs in with email {string} and password {string}")
public void theUserLogsInWithEmailAndPassword(String email, String password) {
    loginPage.login(email, password);
}
```

### Page Objects (for Juniors)

Page Objects encapsulate all interactions with a single screen:

```java
public LoginPage login(String email, String password) {
    return enterEmail(email)
           .enterPassword(password)
           .clickLoginButton();   // fluent – returns `this`
}
```

---

## Configuration

Edit `src/test/resources/config.properties` (or pass `-D` flags to Maven):

```properties
appium.url=http://localhost:4723
device.name=Android Emulator
platform.version=13
app.package=com.wdiodemoapp
app.activity=.MainActivity
app.path=../apps/wdioNativeDemoApp.apk
```

### Override from command line

```bash
# Run on a real device (USB connected)
mvn test -Ddevice.name="Pixel 6" -Dapp.path="/abs/path/to/app.apk"

# Run against a specific Appium port
mvn test -Dappium.url=http://localhost:4724
```

---

## Writing Tests

### Adding a new scenario (Junior task)

1. Open (or create) a `.feature` file in `src/test/resources/features/`.
2. Write the scenario in Gherkin.
3. Run the test – Cucumber will print **undefined step** snippets.
4. Copy the snippets into the appropriate `*Steps.java` class and implement them using the page object.

### Adding a new screen (Intermediate task)

1. Create `src/main/java/com/automation/pages/MyNewPage.java` extending `BasePage`.
2. Add locator constants and action methods.
3. Create `src/test/java/com/automation/steps/MyNewSteps.java`.
4. Create `src/test/resources/features/mynewscreen/mynewscreen.feature`.

---

## Running Tests

### All tests

```bash
mvn test
```

### Filter by Cucumber tag

```bash
# Smoke suite only
mvn test -Dcucumber.filter.tags="@smoke"

# P0 critical tests
mvn test -Dcucumber.filter.tags="@P0"

# Login tests only
mvn test -Dcucumber.filter.tags="@login"

# P0 AND login
mvn test -Dcucumber.filter.tags="@P0 and @login"

# Exclude ignored tests
mvn test -Dcucumber.filter.tags="not @ignore"
```

### Run a single feature file

```bash
mvn test -Dcucumber.features="src/test/resources/features/login/login.feature"
```

### Parallel execution (Senior – see [Advanced Topics](#advanced-topics-senior))

```bash
mvn test -Ddataproviderthreadcount=4
```

---

## Allure Reports

### Generate and open locally

```bash
# After running tests
mvn allure:report
open target/site/allure-maven-plugin/index.html   # macOS
xdg-open target/site/allure-maven-plugin/index.html  # Linux
```

### Serve with live reload (requires Allure CLI)

```bash
allure serve target/allure-results
```

### Report structure

| Section | What you see |
|---|---|
| **Overview** | Pass/fail/skip/broken counts, trend graph |
| **Suites** | Results grouped by feature file |
| **Graphs** | Status, severity, and duration distribution |
| **Timeline** | When each test ran (useful for parallelism) |
| **Behaviors** | Grouped by Feature → Scenario |

### Screenshots on failure

The `Hooks.java` `@After` hook automatically captures a screenshot when a scenario fails and attaches it to **both** the Allure report and the Cucumber HTML report. No extra setup needed.

---

## Tagging Strategy

Tags are defined on `Feature:` and/or `Scenario:` lines in feature files.

### Priority tags

| Tag | When to use |
|---|---|
| `@P0` | Must-pass; blocks release if failing |
| `@P1` | High importance; significant regressions |
| `@P2` | Medium; informative but not blocking |

### Type tags

| Tag | Meaning |
|---|---|
| `@smoke` | Fast sanity check (subset of P0) |
| `@regression` | Full regression suite |
| `@valid-login` | Specific sub-feature tag |
| `@data-driven` | Scenario Outlines |

### Module tags

- `@login` – All login scenarios  
- `@signup` – All sign-up scenarios

---

## Best Practices

### 1 – Locator priority (Accessibility ID first)

```java
// ✅ Best – works on Android and iOS, resilient to layout changes
private static final String LOGIN_BUTTON = "button-LOGIN";  // accessibility_id

// ✅ Acceptable – platform-specific but stable
private static final String ALERT_OK = "android:id/button1";  // resource-id

// ⚠️ Last resort – fragile, breaks on text/layout change
"//android.widget.Button[@text='Login']"  // XPath
```

### 2 – Explicit waits, never `Thread.sleep()`

```java
// ✅ Explicit wait
wait.until(ExpectedConditions.visibilityOfElementLocated(AppiumBy.accessibilityId("button-LOGIN")));

// ❌ Hard sleep – slow and unreliable
Thread.sleep(3000);
```

### 3 – One assertion per scenario

Each scenario should verify **one thing**. This makes failures immediately obvious.

### 4 – Keep step definitions thin

Step definitions are glue. All driver interactions belong in page objects.

```java
// ✅ Thin step
@When("the user logs in with email {string} and password {string}")
public void login(String email, String password) {
    loginPage.login(email, password);   // delegate to page object
}

// ❌ Fat step – don't do this
@When("the user logs in with email {string} and password {string}")
public void login(String email, String password) {
    driver.findElement(AppiumBy.accessibilityId("input-email")).sendKeys(email);
    driver.findElement(AppiumBy.accessibilityId("input-password")).sendKeys(password);
    driver.findElement(AppiumBy.accessibilityId("button-LOGIN")).click();
}
```

### 5 – Name conventions

| Thing | Convention | Example |
|---|---|---|
| Feature file | `kebab-case.feature` | `login.feature` |
| Scenario | Sentence case | `Successful login with valid credentials` |
| Page Object class | `PascalCase + Page` | `LoginPage` |
| Locator constant | `SCREAMING_SNAKE_CASE` | `LOGIN_BUTTON` |
| Step method | `camelCase` | `theUserTapsTheLoginButton` |

---

## Advanced Topics (Senior)

### Parallel Execution

Enable parallel scenario execution in two steps:

**1. `TestRunner.java`** – change `parallel = false` → `true`:

```java
@Override
@DataProvider(parallel = true)
public Object[][] scenarios() {
    return super.scenarios();
}
```

**2. `testng.xml`** – update thread count:

```xml
<suite name="Parallel Suite" parallel="methods" thread-count="3">
```

**3. Command line** – Maven Surefire accepts:

```bash
mvn test -Ddataproviderthreadcount=3
```

> **Note:** `DriverManager` already uses `ThreadLocal<AppiumDriver>` so each thread gets its own isolated driver session – no driver sharing issues.

### Allure History (Trend Charts)

To show trend graphs across CI runs, copy the previous `allure-results/history/` folder into the new `allure-results/` before generating the report:

```bash
# In CI pipeline (see android-java-cucumber-allure.yml)
cp -r allure-history/history target/allure-results/
mvn allure:report
```

Use the `allure-history` artifact from the previous run as a cache.

### Environment-Based Capabilities

Pass environment variables from CI to the capability config:

```bash
mvn test -Dapp.path="$GITHUB_WORKSPACE/apps/wdioNativeDemoApp.apk" \
         -Dplatform.version="$ANDROID_API_LEVEL" \
         -Ddevice.name="$DEVICE_NAME"
```

### Custom Allure Annotations

Enrich step output using Allure Java annotations:

```java
import io.qameta.allure.Step;
import io.qameta.allure.Description;
import io.qameta.allure.Severity;
import io.qameta.allure.SeverityLevel;

@Step("Enter email: {email}")
public LoginPage enterEmail(String email) { ... }

@Severity(SeverityLevel.CRITICAL)
@Description("Validates that a registered user can log in with correct credentials.")
public void validLoginTest() { ... }
```

### Retry Logic for Flaky Tests

Add a TestNG retry analyser:

```java
// RetryAnalyzer.java
public class RetryAnalyzer implements IRetryAnalyzer {
    private int count = 0;
    private static final int MAX_RETRY = 2;

    @Override
    public boolean retry(ITestResult result) {
        if (count < MAX_RETRY) { count++; return true; }
        return false;
    }
}

// In TestRunner or via listener:
@Test(retryAnalyzer = RetryAnalyzer.class)
```

### Page Factory (Alternative to Manual Finds)

For complex screens, consider using Appium's `PageFactory`:

```java
import io.appium.java_client.pagefactory.AppiumFieldDecorator;
import io.appium.java_client.pagefactory.AndroidFindBy;
import org.openqa.selenium.support.PageFactory;

public class LoginPage extends BasePage {

    @AndroidFindBy(accessibility = "input-email")
    private WebElement emailInput;

    public LoginPage() {
        PageFactory.initElements(new AppiumFieldDecorator(driver), this);
    }
}
```

---

## CI/CD Pipeline

The workflow `.github/workflows/android-java-cucumber-allure.yml` runs on every push to `main`/`master` that touches `java-cucumber-android/**` and can be triggered manually.

### Pipeline stages

```
Checkout
  └── Setup Java 11 + Maven cache
       └── Setup Node.js
            └── Install Appium 2 + UIAutomator2
                 └── Verify APK
                      └── Enable KVM
                           └── Start Appium server
                                └── Start Android Emulator (API 33)
                                     └── Install APK
                                          └── mvn test
                                               └── mvn allure:report
                                                    └── Upload artifacts:
                                                         • allure-results
                                                         • allure-report
                                                         • cucumber-html-report
                                                         • appium-server-log
```

### Artifacts (download from GitHub Actions run)

| Artifact | Contents |
|---|---|
| `allure-report` | Full interactive HTML (open `index.html`) |
| `allure-results` | Raw JSON – needed for trend history |
| `cucumber-html-report` | Cucumber native HTML |
| `appium-server-log` | Appium server output for debugging |

### Trigger manually

1. Go to **Actions** tab in GitHub.
2. Select **Android – Java Cucumber TestNG Allure**.
3. Click **Run workflow** → **Run workflow**.

---

## Troubleshooting

### `Connection refused` to Appium

```bash
# Is Appium running?
curl http://localhost:4723/status

# Is the port free?
lsof -i :4723
```

### `Element not found` / `NoSuchElementException`

- Open **Appium Inspector** (`npx appium-inspector`) and inspect the element.
- Increase the wait timeout in `BasePage`:
  ```java
  private static final long DEFAULT_TIMEOUT = 30; // seconds
  ```
- Verify the accessibility ID has not changed in a newer APK version.

### Emulator not detected

```bash
adb devices               # should list emulator-5554
adb kill-server
adb start-server
adb devices
```

### Allure report is empty

Make sure `allure.results.directory` in `allure.properties` matches the `systemPropertyVariables` in `pom.xml`. Both should point to `target/allure-results`.

### Maven `BUILD FAILURE` – cannot find AspectJ weaver

The AspectJ agent path is constructed from your local Maven repository. Run `mvn dependency:resolve` once to ensure all dependencies are downloaded, then re-run `mvn test`.

---

## Contributing

1. Fork the repository.
2. Create a feature branch: `git checkout -b feat/my-new-tests`.
3. Write a failing scenario in a `.feature` file.
4. Implement step definitions and any new page objects.
5. Run `mvn test` locally – all tests must pass.
6. Open a pull request with a clear description.

---

## References

| Resource | URL |
|---|---|
| Appium Java Client | https://github.com/appium/java-client |
| Appium 2 Docs | https://appium.io/docs/en/2.0/ |
| Cucumber Docs | https://cucumber.io/docs/cucumber/ |
| TestNG Docs | https://testng.org/doc/ |
| Allure Report | https://allurereport.org/docs/ |
| WDIO Demo App (source) | https://github.com/webdriverio/native-demo-app |
| Appium Inspector | https://github.com/appium/appium-inspector |

---

*Created by the QA Automation Team as a reference framework for Android mobile test automation.*
