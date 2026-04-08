# Robot Framework Mobile Framework Instructions (Repo-Specific)

This document defines how to analyze, extend, and maintain this repository without breaking existing framework and CI behavior.

Mandatory source-of-truth order for this repository:
1. README.md (used here as framework instruction source)
2. Existing repository structure and implementation files
3. .github/workflows/android-emulator-tests.yml
4. .github/workflows/ios-simulator-tests.yml

Note: The file robot-framework-mobile-instructions.md is not currently present in this repository. README.md and docs/BEST_PRACTICES.md are used as the framework-guideline source.

## A. Framework understanding

- Brief summary of the framework architecture
  - Layered Robot Framework mobile architecture using AppiumLibrary with Page Object Model.
  - Layers are: locators -> page-objects -> common keywords -> test suites.
  - Cross-platform behavior is driven by runtime variables in configs/AppiumConfigs.robot and pipeline-provided variables.

- Key conventions found
  - Test suites under test-cases/<module>/ with descriptive names like LoginTests.robot and SignupTests.robot.
  - Locator variables use UPPER_SNAKE_CASE with LOC_ prefix, e.g., ${LOC_LOGIN_BUTTON}.
  - Tag variables centralized in configs/TagConfigs.robot and reused in tests.
  - Common reusable actions live in resources/keywords/CommonKeywords.robot.
  - Page-object methods use verb-first keyword names (Enter..., Click..., Verify..., Complete...).
  - Setup/teardown are suite-level and rely on Open Test Application and Close Test Application.

- Android strategy
  - Android is the default platform in configs/AppiumConfigs.robot (${PLATFORM_NAME} = ${ANDROID_PLATFORM_NAME}).
  - Uses Appium UIAutomator2 with APK at apps/wdioNativeDemoApp.apk.
  - GitHub workflow boots Android emulator, installs APK via adb, then executes tagged and module-specific robot runs.

- iOS strategy
  - iOS uses XCUITest with app path apps/wdioNativeDemoApp.app.
  - Workflow provisions simulator dynamically, derives runtime/platform version, installs app, sets UDID and bundle ID, then runs robot suites with iOS variables.
  - iOS execution is variable-driven through --variable PLATFORM_NAME:ios, IOS_PLATFORM_VERSION, DEVICE_NAME, UDID, IOS_APP_BUNDLE_ID.

- Pipeline expectations
  - Android workflow is manual-only (workflow_dispatch).
  - iOS workflow supports push, pull_request, and workflow_dispatch.
  - Both workflows:
    - install Python dependencies from requirements.txt
    - install Appium and corresponding driver (uiautomator2 or xcuitest)
    - start Appium on localhost:4723
    - execute multiple robot commands (Smoke, P0, login module, signup module)
    - continue on suite failures (robot commands end with || true)
    - upload results and Appium logs as artifacts

- Important constraints
  - Do not bypass TagConfigs.robot for tag names.
  - Do not hardcode platform behavior in tests when common keyword/config variable mechanism exists.
  - Keep test folder and naming conventions stable so workflow paths (test-cases, test-cases/login, test-cases/signup) remain valid.
  - Preserve compatibility with robot --variable overrides used by CI.

## B. Implementation strategy

- What will be added or changed
  - Add or update only within existing layers:
    - locators in resources/locators/
    - page actions/flows in resources/page-objects/
    - generic reusable behavior in resources/keywords/CommonKeywords.robot
    - suite scenarios in test-cases/<module>/
    - tags in configs/TagConfigs.robot when genuinely new categories are required

- Why it matches the current framework
  - This mirrors the current separation-of-concerns model and existing keyword reuse pattern.
  - It preserves current setup/teardown and variable-driven platform orchestration.

- Which files/folders are involved
  - configs/AppiumConfigs.robot
  - configs/ApplicationConfigs.robot
  - configs/TagConfigs.robot
  - resources/keywords/CommonKeywords.robot
  - resources/locators/*.robot
  - resources/page-objects/*.robot
  - test-cases/<module>/*.robot
  - localization/LocalizationConfig.robot and localization/<lang>.robot (if text assertions change)

- Which existing components will be reused
  - Open Test Application / Close Test Application
  - Wait/interaction wrappers (Click On Element, Input Text Into Field, Wait For Element...)
  - Existing page-object flows (Complete Valid Login Flow, Complete Valid Signup Flow, etc.)
  - Existing tag variables (${TAG_P0}, ${TAG_SMOKE}, ${TAG_MODULE_*}, ${TAG_ANDROID}, ${TAG_IOS}, ${TAG_BOTH_PLATFORMS})

- Impact on Android/iOS pipelines
  - Any new suite must remain discoverable under test-cases.
  - Tags must support existing include filters (Smoke, P0).
  - Avoid breaking execution assumptions for login/signup folder runs.
  - New platform-specific behavior should be controlled through variables and reusable keywords, not duplicated suites, unless existing pattern requires separation.

## C. Proposed solution

Use this change template before creating/modifying tests, resources, locators, keywords, or configs:

1. Mapping to existing pattern
   - Layer selected: [locator | page-object | common keyword | test suite | config]
   - Target path: [exact existing folder]
   - Reused components: [list existing keywords/resources/tags]
   - Platform impact: [Android | iOS | both]
   - Pipeline compatibility: [Smoke/P0/login/signup path impact]

2. Implementation rules (must follow)
   - Add locators only in resources/locators/<ScreenName>Locators.robot.
   - Add business flow keywords only in resources/page-objects/<ScreenName>PO.robot.
   - Keep cross-screen utility logic in resources/keywords/CommonKeywords.robot.
   - Reference TagConfigs.robot tag variables in tests; do not inline raw tag strings when an existing variable exists.
   - Keep suite-level setup and teardown aligned with existing patterns.
   - Prefer accessibility_id locators first; keep xpath as fallback where needed.

3. Robot Framework snippet patterns (repo-aligned)

```robotframework
*** Settings ***
Resource         ../../resources/page-objects/NavigationBarPO.robot
Resource         ../../resources/page-objects/<ScreenName>PO.robot
Resource         ../../configs/TagConfigs.robot

Test Setup       Open Test Application
Test Teardown    Close Test Application

Default Tags     ${TAG_MODULE_<MODULE>}    ${TAG_ANDROID}


*** Test Cases ***
TCxxx - Verify <Scenario>
    [Documentation]    <Scenario description>
    [Tags]    ${TAG_P1}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}
    Navigate To <Screen>
    <Reusable Flow Keyword>
```

```robotframework
*** Keywords ***
<Business Flow Keyword>
    [Documentation]    <Flow description>
    [Arguments]        ${arg1}    ${arg2}
    Verify <Screen> Is Displayed
    <Atomic Action Keyword>
    <Verification Keyword>
```

```robotframework
*** Variables ***
${LOC_<SCREEN>_<ELEMENT>}    accessibility_id=<value>
```

4. Pipeline-aligned execution assumptions
   - Ensure tests can run with runtime variable overrides used by CI:
     - Android: PLATFORM_NAME:android, ANDROID_PLATFORM_VERSION, ENABLE_VIDEO_RECORDING
     - iOS: PLATFORM_NAME:ios, IOS_PLATFORM_VERSION, DEVICE_NAME, UDID, IOS_APP_BUNDLE_ID, ENABLE_VIDEO_RECORDING
   - Preserve suite compatibility for:
     - robot --include Smoke test-cases
     - robot --include P0 test-cases
     - robot test-cases/login
     - robot test-cases/signup

## D. Validation checklist

- Matches robot-framework-mobile-instructions.md
  - Status: Not directly verifiable because the file is missing in this repository.
  - Applied substitute: README.md and docs/BEST_PRACTICES.md conventions.

- Compatible with mobile-android-test.yml
  - Status: Mapped to existing equivalent .github/workflows/android-emulator-tests.yml.
  - Smoke/P0/login/signup execution behavior preserved.

- Compatible with mobile-ios-tests.yml
  - Status: Mapped to existing equivalent .github/workflows/ios-simulator-tests.yml.
  - iOS variable injection and simulator/app setup assumptions preserved.

- Follows naming conventions
  - Uses existing naming pattern for locators, page objects, and tests.

- Uses existing structure
  - Keeps all additions in current folders; no framework redesign.

- Reuses keywords/resources where possible
  - Requires consumption of CommonKeywords and existing page-object flows first.

- Ready for pipeline execution
  - Designed to stay compatible with existing workflow command filters and folder targets.

## E. Notes / assumptions

- Assumption 1: Requested files robot-framework-mobile-instructions.md, mobile-android-test.yml, and mobile-ios-tests.yml are intended to correspond to README.md, .github/workflows/android-emulator-tests.yml, and .github/workflows/ios-simulator-tests.yml in this repository.
- Assumption 2: New Android/iOS test additions should continue using shared tests with variable-driven platform handling, unless an explicit existing split pattern is present.
- Assumption 3: Tag variables in TagConfigs.robot are the authoritative taxonomy and should remain the default source for test tagging.
- Needs confirmation: If you intended different files (same names but from another branch/path), provide their exact paths and this document should be regenerated against those files only.