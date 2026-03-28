# Video Recording and Screenshot Capture Guide

This guide explains how to use the video recording and automatic screenshot capture features in the Robot Framework Mobile Automation Framework.

## Table of Contents
- [Overview](#overview)
- [Screenshot on Failure](#screenshot-on-failure)
- [Video Recording](#video-recording)
- [Viewing Reports](#viewing-reports)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)

## Overview

The framework provides two powerful debugging and documentation features:

1. **Automatic Screenshot on Failure**: Captures screenshots automatically when any keyword fails
2. **Video Recording**: Records the entire test execution as a video file

Both screenshots and videos are automatically embedded in the Robot Framework HTML reports for easy review.

## Screenshot on Failure

### How It Works

Screenshots are **automatically captured** when any test step fails. This is configured in the `Open Test Application` keyword.

```robotframework
Register Keyword To Run On Failure    Capture Failure Screenshot
```

### What Gets Captured

- **Automatically**: Any keyword failure triggers a screenshot
- **Location**: Screenshots are saved in the `results/` directory (or custom output directory)
- **Naming**: Screenshots are automatically named with timestamps
- **Report Integration**: Screenshots appear inline in the HTML report at the point of failure

### Manual Screenshots

You can also capture screenshots manually in your tests:

```robotframework
*** Test Cases ***
My Test Case
    Navigate To Login Screen
    Capture Page Screenshot    custom_name.png
    Enter Email Address    test@example.com
```

### Advanced Screenshot Options

Use the `Take Screenshot With Timestamp` keyword for automatic timestamp naming:

```robotframework
*** Test Cases ***
My Test Case
    Navigate To Login Screen
    ${screenshot_path}=    Take Screenshot With Timestamp    login_screen
    Log    Screenshot saved at: ${screenshot_path}
```

## Video Recording

### Enabling Video Recording

Video recording is **disabled by default** to improve test execution speed. Enable it in two ways:

#### Method 1: Global Configuration (Recommended)

Edit `configs/ApplicationConfigs.robot`:

```robotframework
# Video Recording Configuration
${ENABLE_VIDEO_RECORDING}         True    # Change from False to True
```

#### Method 2: Command Line Override

```bash
robot --variable ENABLE_VIDEO_RECORDING:True test-cases/login/LoginTests.robot
```

### How It Works

When enabled, video recording:
1. **Starts** when the application opens (in Test Setup)
2. **Records** all screen activity during the test
3. **Stops** when the test completes (in Test Teardown)
4. **Saves** as an MP4 file in the results directory
5. **Embeds** in the HTML report for inline playback

### Using Video Recording in Tests

#### Option 1: Use the Enhanced Setup/Teardown

Replace your test setup/teardown with video-enabled versions:

```robotframework
*** Settings ***
Resource    ../../resources/keywords/CommonKeywords.robot

Test Setup       Setup Test With Video
Test Teardown    Teardown Test With Video
```

#### Option 2: Manual Control

Control video recording manually in specific tests:

```robotframework
*** Test Cases ***
Critical Test With Video
    [Setup]    Open Test Application
    Start Video Recording
    
    # Your test steps here
    Navigate To Login Screen
    Login With Credentials    user@test.com    password123
    
    [Teardown]    Run Keywords
    ...    Stop Video Recording    ${TEST_NAME}
    ...    AND    Close Test Application
```

### Video File Details

- **Format**: MP4 (H.264 codec)
- **Naming**: Based on test name (automatically sanitized)
- **Size**: Varies based on test duration (~1-5 MB per minute)
- **Location**: Same directory as HTML report (`results/` by default)

## Viewing Reports

### Opening HTML Reports

After test execution:

```bash
# Reports are in the results directory
results/
├── log.html          # Detailed log file
├── report.html       # Executive summary
├── output.xml        # Machine-readable results
├── screenshot-*.png  # Screenshots (if any failures)
└── TestName_*.mp4    # Video recordings (if enabled)
```

Open in your browser:
```bash
# Windows
start results/report.html

# Mac
open results/report.html

# Linux
xdg-open results/report.html
```

### Screenshots in Reports

Screenshots appear automatically at the failure point:

```
✖ TC001 - Login Test
  └─ Enter Email Address    invalid@email
     ├─ Element not found
     └─ 📷 Screenshot: selenium-screenshot-1.png
```

Click the screenshot link to view the full image inline.

### Videos in Reports

Videos are embedded as HTML5 video players:

```
✔ TC002 - Login Success Test
  └─ 🎥 Video Recording
     ┌─────────────────────────────┐
     │ ▶️  [Video Player]         │
     │ Timeline: 00:15            │
     └─────────────────────────────┘
```

Videos can be:
- **Played inline** directly in the report
- **Downloaded** via right-click → "Save Video As"
- **Scrubbed** through timeline to find specific moments

## Configuration

### Performance Optimization

Video recording adds overhead (~10-30% slower execution). Optimize with:

```robotframework
# configs/ApplicationConfigs.robot

# Enable only for important test suites
${ENABLE_VIDEO_RECORDING}         False

# Or use tag-based conditional recording
Run Keyword If    '${TAG_P0}' in @{TEST_TAGS}    Start Video Recording
```

### Video Quality Settings

Appium's screen recording options (Android specific):

```robotframework
Start Recording Screen    
...    videoSize=720x1280      # Resolution
...    bitRate=4000000         # 4 Mbps
...    timeLimit=180           # Max 3 minutes
```

### Screenshot Format

Configure screenshot format if needed:

```robotframework
# For JPEG instead of PNG (smaller file size)
Set Screenshot Directory    ${OUTPUT_DIR}
Screenshot On Failure    .jpg
```

## Troubleshooting

### Screenshots Not Appearing

**Problem**: Screenshots not embedded in HTML report

**Solutions**:
1. Check file paths are relative to OUTPUT_DIR
2. Verify `Capture Page Screenshot` is called successfully
3. Ensure browser security settings allow embedded images

```robotframework
# Verify screenshot functionality
${path}=    Capture Page Screenshot
Log    Screenshot location: ${path}
```

### Video Recording Fails to Start

**Problem**: Error when starting video recording

**Possible Causes & Solutions**:

1. **Appium version too old**
   ```bash
   npm install -g appium@latest
   ```

2. **Insufficient device storage**
   ```bash
   adb shell df -h
   ```

3. **Permissions issue (Android)**
   ```robotframework
   # Ensure auto-grant permissions is enabled
   ${AUTO_GRANT_PERMISSIONS}    True
   ```

### Video Not Embedded in Report

**Problem**: Video file exists but doesn't play in report

**Solutions**:

1. **Check file path in HTML**
   - Video must be in same directory as report.html
   - Or use relative path from report location

2. **Verify video file is valid**
   ```bash
   # Try playing directly
   start results/TestName.mp4
   ```

3. **Check base64 decoding**
   ```robotframework
   # Verify base64 library is imported
   Library    base64
   ```

### Large Report Files

**Problem**: Reports too large to open in browser

**Solutions**:

1. **Disable video for long-running tests**
   ```robotframework
   ${ENABLE_VIDEO_RECORDING}    False
   ```

2. **Record only on failure**
   ```robotframework
   [Teardown]    Run Keyword If Test Failed    Stop Video Recording
   ```

3. **Use external video storage**
   ```robotframework
   # Move videos to separate directory
   Move File    ${OUTPUT_DIR}/*.mp4    ${OUTPUT_DIR}/videos/
   ```

## Best Practices

### When to Use Video Recording

✅ **USE VIDEO FOR**:
- Critical smoke tests (P0)
- Debugging flaky tests
- Visual regression testing
- Demo recordings for stakeholders
- Complex user flows that are hard to debug

❌ **AVOID VIDEO FOR**:
- Unit-level component tests
- CI/CD pipelines (increases execution time)
- Tests with known stable behavior
- Performance/load testing

### Hybrid Approach

```robotframework
*** Settings ***
# Default: No video
Test Setup       Open Test Application
Test Teardown    Close Test Application

*** Test Cases ***
TC001 - Critical Login Flow
    [Tags]    P0    smoke
    # Override for critical tests
    [Setup]    Setup Test With Video
    [Teardown]    Teardown Test With Video
    
    Navigate To Login Screen
    Login With Credentials    ${VALID_EMAIL}    ${VALID_PASSWORD}

TC002 - Simple Validation
    [Tags]    P2    functional
    # Uses default setup (no video)
    
    Navigate To Login Screen
    Verify Email Field Is Visible
```

### Storage Management

```bash
# Clean up old videos periodically
find results/ -name "*.mp4" -mtime +7 -delete

# Keep only failed test videos
# (Implement in custom teardown)
```

## Examples

### Example 1: Video Recording for Entire Suite

```robotframework
*** Settings ***
Documentation    Login Test Suite with Video Recording

Resource    ../../resources/keywords/CommonKeywords.robot

Suite Setup      Set Global Variable    ${ENABLE_VIDEO_RECORDING}    True
Test Setup       Setup Test With Video
Test Teardown    Teardown Test With Video

*** Test Cases ***
TC001 - Valid Login
    Navigate To Login Screen
    Login With Credentials    user@test.com    password123
    Verify Home Screen Is Displayed
```

### Example 2: Conditional Video Recording

```robotframework
*** Test Cases ***
TC001 - Conditional Video Test
    [Tags]    critical
    
    # Enable video only for critical tests
    ${is_critical}=    Evaluate    'critical' in ${TEST_TAGS}
    Run Keyword If    ${is_critical}    Start Video Recording
    
    # Test steps
    Navigate To Login Screen
    Login With Credentials    user@test.com    password123
    
    [Teardown]    Run Keywords
    ...    Run Keyword If    ${is_critical}    Stop Video Recording    ${TEST_NAME}
    ...    AND    Close Test Application
```

### Example 3: Video on Failure Only

```robotframework
*** Keywords ***
Teardown With Video On Failure
    ${test_status}=    Run Keyword And Return Status    Variable Should Exist    ${TEST_STATUS}
    Run Keyword If    '${TEST_STATUS}' == 'FAIL'    Stop Video Recording    ${TEST_NAME}_FAILED
    Close Test Application

*** Test Cases ***
TC001 - Record Only Failures
    [Setup]    Setup Test With Video
    [Teardown]    Teardown With Video On Failure
    
    Navigate To Login Screen
    Login With Credentials    wrong@email.com    wrongpass
```

## CI/CD Integration

### GitHub Actions Example

```yaml
- name: Run Tests with Screenshots Only
  run: |
    robot --variable ENABLE_VIDEO_RECORDING:False \
          --outputdir results \
          test-cases/

- name: Run Critical Tests with Video
  run: |
    robot --variable ENABLE_VIDEO_RECORDING:True \
          --include P0 \
          --outputdir results \
          test-cases/

- name: Upload Test Artifacts
  uses: actions/upload-artifact@v3
  if: always()
  with:
    name: test-results
    path: |
      results/**/*.html
      results/**/*.xml
      results/**/*.png
      results/**/*.mp4
```

## Summary

- **Screenshots**: Always captured on failure automatically
- **Videos**: Optional, enable via `ENABLE_VIDEO_RECORDING` variable
- **Reports**: Both are embedded in HTML reports for easy viewing
- **Performance**: Video adds overhead, use selectively
- **Storage**: Videos in MP4 format, screenshots in PNG
- **Debugging**: Essential tools for troubleshooting test failures

For more information, see:
- [BEST_PRACTICES.md](./BEST_PRACTICES.md)
- [README.md](../README.md)
- [Robot Framework Documentation](https://robotframework.org)
