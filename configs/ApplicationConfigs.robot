*** Settings ***
Documentation    Application Configuration File
...              This file contains application-level configuration and retry settings
...              Reference: https://docs.robotframework.org/docs/different_libraries/appium

*** Variables ***
# Application Information
${APP_NAME}                       WDIO Demo App
${APP_VERSION}                    1.0.0

# Timeout Settings (in seconds)
${TIMEOUT}                        30
${IMPLICIT_WAIT}                  10
${EXPLICIT_WAIT}                  20
${PAGE_LOAD_TIMEOUT}              30
${SCREENSHOT_TIMEOUT}             5

# Retry Configuration
# SMALL_RETRY_SCALE: For quick operations (clicks, visibility checks)
# MEDIUM_RETRY_SCALE: For medium operations (page loads, validations)
# LARGE_RETRY_SCALE: For slow operations (server calls, heavy processing)
${SMALL_RETRY_SCALE}              3
${MEDIUM_RETRY_SCALE}             5
${LARGE_RETRY_SCALE}              10
${RETRY_DELAY}                    2s

# Swipe Configuration
${SWIPE_DURATION}                 1000
${SWIPE_START_PERCENTAGE}         50
${SWIPE_END_PERCENTAGE}           20

# Video Recording Configuration
# Set to True to enable video recording for all tests (increases execution time)
# Set to False to disable video recording (recommended for CI/CD)
${ENABLE_VIDEO_RECORDING}         False

# Screenshot Configuration
${SCREENSHOT_ON_FAILURE}          true
${SCREENSHOT_DIRECTORY}           ${CURDIR}/../results/screenshots

# Logging Configuration
${LOG_LEVEL}                      INFO
${CONSOLE_LOG_LEVEL}              DEBUG

# Test Data Configuration
${TEST_DATA_DIRECTORY}            ${CURDIR}/../test-data
${EXCEL_TEST_DATA}                ${TEST_DATA_DIRECTORY}/test-data.xlsx

# Wait Strategy
${WAIT_STRATEGY_INTELLIGENT}      true
${WAIT_BEFORE_ACTION}             1
${WAIT_AFTER_ACTION}              1
