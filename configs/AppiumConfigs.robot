*** Settings ***
Documentation    Appium Configuration File
...              This file contains all Appium server and device configuration settings
...              Reference: https://docs.robotframework.org/docs/different_libraries/appium

*** Variables ***
# Appium Server Configuration
${APPIUM_SERVER_URL}              http://localhost:4723
${APPIUM_SERVER_HOST}             localhost
${APPIUM_SERVER_PORT}             4723

# Platform Selection (android or ios)
${PLATFORM_NAME}                  ${ANDROID_PLATFORM_NAME}

# Android Configuration
${ANDROID_AUTOMATION_NAME}        UIAutomator2
${ANDROID_APP}                    ${CURDIR}/../apps/wdioNativeDemoApp.apk
${ANDROID_PLATFORM_NAME}          android
${ANDROID_PLATFORM_VERSION}       %{ANDROID_PLATFORM_VERSION=13}
${ANDROID_APP_PACKAGE}            com.wdiodemoapp
${ANDROID_APP_ACTIVITY}           .MainActivity
${ANDROID_DEVICE_NAME}            Android Emulator
${ANDROID_DEVICE_UDID}            emulator-5554

# iOS Configuration
${IOS_AUTOMATION_NAME}            XCUITest
${IOS_APP}                        ${CURDIR}/../apps/wdioNativeDemoApp.app
${IOS_PLATFORM_NAME}              ios
${IOS_PLATFORM_VERSION}           %{IOS_PLATFORM_VERSION=16.1}
${IOS_APP_BUNDLE_ID}              com.wdiodemoapp
${IOS_DEVICE_NAME}                %{DEVICE_NAME=iPhone 14}
${IOS_DEVICE_UDID}                %{UDID=auto}

# Appium Capabilities - Common
${AUTO_GRANT_PERMISSIONS}         true
${AUTO_ACCEPT_ALERTS}             true
${NO_RESET}                       false
${FULL_RESET}                     false
${NEW_COMMAND_TIMEOUT}            300

# Appium Capabilities - Android Specific
${ANDROID_AUTO_GRANT_PERMISSIONS}    true
${ANDROID_DISABLE_ANIMATIONS}        true
${ANDROID_SKIP_UNLOCK}               true
${ANDROID_UNLOCK_TYPE}               pin
${ANDROID_UNLOCK_KEY}                1111

# Appium Capabilities - iOS Specific
${IOS_AUTO_ACCEPT_ALERTS}         true
${IOS_SHOW_IOS_LOG}               true
${IOS_USE_NEW_WDA}                false
${IOS_WDA_STARTUP_RETRIES}        3
${IOS_WDA_STARTUP_RETRY_INTERVAL} 10000
${IOS_WDA_LAUNCH_TIMEOUT}         240000
${IOS_WDA_CONNECTION_TIMEOUT}     240000
${IOS_DERIVED_DATA_PATH}          /tmp/appium-webdriveragent
