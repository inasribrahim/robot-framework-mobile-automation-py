# Robot Framework Mobile Automation Framework

A comprehensive, production-ready mobile test automation framework using Robot Framework and Appium for both Android and iOS platforms.

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Framework Architecture](#framework-architecture)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Configuration](#configuration)
- [Writing Tests](#writing-tests)
- [Running Tests](#running-tests)
- [Tagging Strategy](#tagging-strategy)
- [Best Practices](#best-practices)
- [CI/CD Integration](#cicd-integration)
- [Reporting](#reporting)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [References](#references)

## Overview

This framework provides a robust foundation for mobile application testing using Robot Framework and Appium. It implements the Page Object Model (POM) design pattern with best practices for maintainability, scalability, and reusability.

### Reference Documentation

- Official Appium Library Documentation: [https://docs.robotframework.org/docs/different_libraries/appium](https://docs.robotframework.org/docs/different_libraries/appium)
- Robot Framework User Guide: [https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)

## Key Features

- **Cross-Platform Support**: Single codebase for both Android and iOS testing
- **Page Object Model**: Maintainable and reusable page object architecture
- **Multilingual Support**: Localization system for testing apps in multiple languages
- **Comprehensive Tagging**: Priority-based tagging (P0, P1, P2) with module and sub-module organization
- **Retry Mechanism**: Configurable retry logic for flaky element interactions
- **CI/CD Ready**: GitHub Actions workflow for automated testing
- **Detailed Reporting**: Robot Framework HTML reports with screenshots
- **Best Practices**: Industry-standard patterns and conventions

## Framework Architecture

```
robot-framewok-mobile/
├── .github/
│   └── workflows/
│       └── android-emulator-tests.yml    # CI/CD pipeline
├── apps/                                  # Mobile application files
├── configs/                               # Configuration files
│   ├── AppiumConfigs.robot               # Appium server & device settings
│   ├── ApplicationConfigs.robot          # App-level configs & retry settings
│   └── TagConfigs.robot                  # Centralized tag definitions
├── localization/                          # Multilingual support
│   ├── LocalizationConfig.robot          # Language selection
│   ├── en.robot                          # English strings
│   └── ar.robot                          # Arabic strings
├── resources/                             # Reusable resources
│   ├── keywords/
│   │   └── CommonKeywords.robot          # Common reusable keywords
│   ├── locators/
│   │   ├── LoginScreenLocators.robot     # Login screen element locators
│   │   ├── SignupScreenLocators.robot    # Signup screen element locators
│   │   └── NavigationBarLocators.robot   # Navigation element locators
│   └── page-objects/
│       ├── LoginScreenPO.robot           # Login page object
│       ├── SignupScreenPO.robot          # Signup page object
│       └── NavigationBarPO.robot         # Navigation page object
├── test-cases/                            # Test suites
│   ├── login/
│   │   └── LoginTests.robot              # Login test cases
│   └── signup/
│       └── SignupTests.robot             # Signup test cases
├── results/                               # Test execution results
├── .gitignore                            # Git ignore file
├── requirements.txt                      # Python dependencies
└── README.md                             # This file
```

## Prerequisites

### Required Software

1. **Python** (3.9 or higher)
   ```bash
   python --version
   ```

2. **Node.js** (14.x or higher) for Appium
   ```bash
   node --version
   ```

3. **Java JDK** (11 or higher)
   ```bash
   java --version
   ```

4. **Android Studio** (for Android testing)
   - Download from: [https://developer.android.com/studio](https://developer.android.com/studio)
   - Set ANDROID_HOME environment variable

5. **Xcode** (for iOS testing on macOS)
   - Download from Mac App Store
   - Install Xcode Command Line Tools

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/inasribrahim/robot-framework-mobile-automation-py.git
cd robot-framework-mobile-automation-py
```

### 2. Install Python Dependencies

```bash
pip install -r requirements.txt
```

### 3. Install Appium 2.0

```bash
npm install -g appium@next
```

### 4. Install Appium Drivers

```bash
# For Android
appium driver install uiautomator2

# For iOS
appium driver install xcuitest
```

### 5. Verify Installation

```bash
appium driver list --installed
```

## Configuration

### Platform Selection

Edit `configs/AppiumConfigs.robot` to choose your platform:

```robotframework
${PLATFORM_NAME}    ${ANDROID_PLATFORM_NAME}  # For Android
# OR
${PLATFORM_NAME}    ${IOS_PLATFORM_NAME}      # For iOS
```

### Device Configuration

**Android Configuration:**
```robotframework
${ANDROID_DEVICE_NAME}        Android Emulator
${ANDROID_PLATFORM_VERSION}   13
```

**iOS Configuration:**
```robotframework
${IOS_DEVICE_NAME}            iPhone 14
${IOS_PLATFORM_VERSION}       16.1
```

### Language Selection

Edit `localization/LocalizationConfig.robot`:

```robotframework
${LANGUAGE}    en  # English
# OR
${LANGUAGE}    ar  # Arabic
```

### Retry Configuration

Adjust retry scales in `configs/ApplicationConfigs.robot`:

```robotframework
${SMALL_RETRY_SCALE}     3   # Quick operations
${MEDIUM_RETRY_SCALE}    5   # Medium operations
${LARGE_RETRY_SCALE}     10  # Slow operations
${RETRY_DELAY}           2s  # Delay between retries
```

## Writing Tests

### Test Case Structure

```robotframework
*** Settings ***
Documentation    Test suite description
Resource         ../../resources/page-objects/LoginScreenPO.robot
Test Setup       Open Test Application
Test Teardown    Close Test Application

*** Test Cases ***
TC001 - Test Case Name
    [Documentation]    Detailed test description
    [Tags]    ${TAG_P0}    ${TAG_MODULE_LOGIN}    ${TAG_SMOKE}
    
    Navigate To Login Screen
    Complete Valid Login Flow    ${EMAIL}    ${PASSWORD}
```

### Page Object Pattern

**Locators (Separation of Concerns):**
```robotframework
# resources/locators/LoginScreenLocators.robot
${LOC_LOGIN_EMAIL_INPUT}    accessibility_id=input-email
${LOC_LOGIN_BUTTON}         accessibility_id=button-LOGIN
```

**Page Objects (Business Logic):**
```robotframework
# resources/page-objects/LoginScreenPO.robot
Login With Credentials
    [Arguments]    ${email}    ${password}
    Enter Email Address    ${email}
    Enter Password        ${password}
    Click Login Button
```

## Running Tests

### Start Appium Server

```bash
appium --log-level info
```

### Run All Tests

```bash
robot --outputdir results test-cases/
```

### Run Tests by Tag

```bash
# Smoke tests only
robot --outputdir results --include Smoke test-cases/

# P0 critical tests
robot --outputdir results --include P0 test-cases/

# Login module tests
robot --outputdir results --include Module:Login test-cases/

# Regression suite
robot --outputdir results --include Regression test-cases/
```

### Run Specific Test Suite

```bash
# Login tests only
robot --outputdir results test-cases/login/LoginTests.robot

# Signup tests only
robot --outputdir results test-cases/signup/SignupTests.robot
```

### Run Tests with Variables

```bash
robot --outputdir results \
      --variable PLATFORM_NAME:android \
      --variable ANDROID_PLATFORM_VERSION:13 \
      test-cases/
```

### Parallel Execution

```bash
pabot --processes 4 --outputdir results test-cases/
```

## Tagging Strategy

### Priority Tags

| Tag | Description | Usage |
|-----|-------------|-------|
| P0 | Critical/Blocker | Must pass for release |
| P1 | High Priority | Important for release |
| P2 | Medium Priority | Should pass but not blocking |
| P3 | Low Priority | Nice to have |

### Module Tags

- `Module:Login` - Login functionality
- `Module:Signup` - Signup functionality
- `Module:Home` - Home screen
- `Module:Profile` - Profile management

### Sub-Module Tags

- `SubModule:ValidLogin` - Valid login scenarios
- `SubModule:InvalidLogin` - Invalid login scenarios
- `SubModule:LoginValidation` - Field validation tests

### Test Type Tags

- `Smoke` - Quick smoke tests
- `Regression` - Regression test suite
- `Sanity` - Basic sanity checks
- `Functional` - Functional testing
- `E2E` - End-to-end scenarios

### Tag Combination Examples

```bash
# Critical smoke tests
robot --include P0ANDSmoke test-cases/

# Login regression
robot --include Module:LoginANDRegression test-cases/

# All P0 and P1
robot --include P0ORP1 test-cases/
```

## Best Practices

### 1. Element Locator Strategy

**Priority Order:**
1. `accessibility_id` (Recommended - cross-platform)
2. `id` (Platform specific)
3. `xpath` (Fallback only)

```robotframework
# Best Practice
${LOC_ELEMENT}    accessibility_id=login-button

# Acceptable
${LOC_ELEMENT}    id=com.app:id/login

# Avoid (use only as last resort)
${LOC_ELEMENT}    xpath=//android.widget.Button[@text='Login']
```

### 2. Wait Strategies

Always use explicit waits with retry mechanisms:

```robotframework
# Good
Wait For Element To Be Visible    ${locator}    ${SMALL_RETRY_SCALE}

# Avoid
Sleep    5s
```

### 3. Test Data Management

Use variables for test data:

```robotframework
# In test file
${VALID_EMAIL}    test@example.com
${VALID_PASSWORD}    Password123

# In localization file
${LOGIN_SUCCESS_MESSAGE}    You are logged in!
```

### 4. Error Handling

Implement proper error handling:

```robotframework
Run Keyword And Ignore Error    Close Application
Run Keyword And Return Status    Element Should Be Visible    ${locator}
```

### 5. Documentation

Document all keywords:

```robotframework
Keyword Name
    [Documentation]    Clear description of what the keyword does
    ...                Additional details if needed
    [Arguments]        ${param1}    ${param2}
    [Tags]            keyword-tag
    
    # Implementation
```

### 6. Resource Organization

- Keep locators separate from page objects
- Group related keywords in page objects
- Use common keywords for reusable actions
- Centralize configuration

### 7. Naming Conventions

- **Test Cases**: `TC001 - Descriptive Name`
- **Keywords**: `Action Object` (e.g., `Click Login Button`)
- **Variables**: `${UPPER_CASE_WITH_UNDERSCORES}`
- **Locators**: `${LOC_SCREEN_ELEMENT}` (e.g., `${LOC_LOGIN_EMAIL_INPUT}`)

### 8. Code Reusability

Create reusable keyword flows:

```robotframework
Complete Valid Login Flow
    [Arguments]    ${email}    ${password}
    Verify Login Screen Is Displayed
    Login With Credentials    ${email}    ${password}
    Verify Login Success Alert Is Displayed
    Click Alert OK Button
```

## CI/CD Integration

### GitHub Actions

The framework includes a complete GitHub Actions workflow for automated testing.

**Workflow Features:**
- Automatic emulator setup
- Parallel test execution
- Test result publishing
- Artifact upload
- Failed test screenshots

**Manual Trigger:**
```bash
# Via GitHub UI
Actions > Android Emulator Robot Framework Tests > Run workflow
```

**Viewing Results:**
- Navigate to Actions tab
- Select workflow run
- Download test results artifact

## Reporting

### HTML Reports

After test execution, view the reports:

```bash
# Main report
open results/report.html

# Detailed log
open results/log.html

# Test output
open results/output.xml
```

### Report Features

- Test case pass/fail status
- Execution time
- Error messages
- **Screenshots on failure** (automatically captured)
- **Video recordings** (optional, configurable)
- Keyword-level details
- Embedded multimedia (images and videos inline)

### Screenshots and Video Recording

The framework includes powerful debugging features:

#### **Automatic Screenshots on Failure** ✅
- Enabled by default
- Captures screen state at moment of failure
- Embedded inline in HTML reports
- No configuration required

#### **Video Recording** 🎥
- Optional feature (disabled by default)
- Records entire test execution
- MP4 format with HTML5 player in reports
- Enable globally or per-test

**Enable video recording:**

```robotframework
# In configs/ApplicationConfigs.robot
${ENABLE_VIDEO_RECORDING}    True

# Or via command line
robot --variable ENABLE_VIDEO_RECORDING:True test-cases/
```

**Use in tests:**

```robotframework
*** Settings ***
Test Setup       Setup Test With Video
Test Teardown    Teardown Test With Video
```

📖 **Comprehensive Guide**: See [docs/VIDEO_AND_SCREENSHOTS.md](docs/VIDEO_AND_SCREENSHOTS.md) for:
- Detailed configuration options
- Best practices for video recording
- Troubleshooting tips
- CI/CD integration examples
- Storage optimization strategies

### Custom Reports

Generate custom reports:

```bash
rebot --outputdir custom-results \
      --name "Custom Report" \
      --include P0 \
      results/output.xml
```

## Troubleshooting

### Common Issues

**1. Appium Server Not Starting**
```bash
# Check if port 4723 is in use
lsof -i :4723

# Kill process and restart
kill -9 $(lsof -t -i:4723)
appium
```

**2. Element Not Found**
- Verify locator with Appium Inspector
- Increase retry scale
- Add explicit waits
- Check if element is in viewport

**3. Emulator Not Starting**
```bash
# List available emulators
emulator -list-avds

# Start specific emulator
emulator -avd <avd-name>
```

**4. iOS WebDriverAgent Issues**
```bash
# Reinstall WDA
appium driver uninstall xcuitest
appium driver install xcuitest
```

**5. Permission Denied Errors**
```bash
# Fix permissions
chmod +x start_emulator.sh
```

### Debug Mode

Run tests with debug logging:

```bash
robot --loglevel DEBUG --outputdir results test-cases/
```

## Best Practices from Industry

### Setup Best Practices

1. **Environment Separation**
   - Maintain separate configs for dev, staging, prod
   - Use environment variables for sensitive data

2. **Version Control**
   - Never commit sensitive credentials
   - Use `.gitignore` for local configurations
   - Tag releases properly

3. **Dependency Management**
   - Pin specific versions in `requirements.txt`
   - Document any manual setup steps
   - Use virtual environments

4. **Test Data**
   - Use data-driven testing for multiple scenarios
   - Keep test data separate from test logic
   - Clean up test data after execution

5. **Parallel Execution**
   - Use pabot for faster execution
   - Ensure tests are independent
   - Manage shared resources carefully

6. **Continuous Improvement**
   - Review failed tests immediately
   - Maintain test suite regularly
   - Remove obsolete tests

## Contributing

### Pull Request Process

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new features
5. Run full test suite
6. Submit pull request with description

### Code Standards

- Follow Robot Framework style guide
- Add documentation to all keywords
- Include appropriate tags
- Update README if needed

## References

### Official Documentation

- **Robot Framework**: [https://robotframework.org](https://robotframework.org)
- **Appium Library**: [https://docs.robotframework.org/docs/different_libraries/appium](https://docs.robotframework.org/docs/different_libraries/appium)
- **Appium**: [https://appium.io](https://appium.io)
- **Robot Framework Guides**: [https://robotframework.org/robotframework/](https://robotframework.org/robotframework/)

### Tools

- **Appium Inspector**: [https://github.com/appium/appium-inspector](https://github.com/appium/appium-inspector)
- **Android Studio**: [https://developer.android.com/studio](https://developer.android.com/studio)
- **Xcode**: [https://developer.apple.com/xcode/](https://developer.apple.com/xcode/)

### Community

- **Robot Framework Forum**: [https://forum.robotframework.org](https://forum.robotframework.org)
- **Robot Framework Slack**: [https://robotframework-slack-invite.herokuapp.com](https://robotframework-slack-invite.herokuapp.com)

## License

This project is licensed under the MIT License.

## Author

Created by QA Automation Team

## Changelog

### Version 1.0.0 (Initial Release)
- Complete framework setup
- Android and iOS support
- Localization system
- Comprehensive tagging strategy
- GitHub Actions CI/CD
- Login and Signup test suites
