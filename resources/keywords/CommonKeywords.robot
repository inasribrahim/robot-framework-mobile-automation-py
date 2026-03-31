*** Settings ***
Documentation    Common Keywords Library
...              This library contains reusable keywords across all page objects
...              Reference: https://docs.robotframework.org/docs/different_libraries/appium

Resource         ../../configs/ApplicationConfigs.robot
Resource         ../../configs/AppiumConfigs.robot
Resource         ../../localization/LocalizationConfig.robot

Library          String
Library          OperatingSystem
Library          DateTime
Library          Collections
Library          AppiumLibrary
Library          base64


*** Keywords ***
Open Test Application
    [Documentation]    Open the mobile application based on platform configuration
    ...                Automatically selects Android or iOS based on PLATFORM_NAME variable
    ...                Takes screenshot on failure for debugging
    [Tags]            setup    initialization
    
    ${platform_normalized}=    Convert To Lower Case    ${PLATFORM_NAME}
    ${android_normalized}=     Convert To Lower Case    ${ANDROID_PLATFORM_NAME}
    ${ios_normalized}=         Convert To Lower Case    ${IOS_PLATFORM_NAME}

    Run Keyword If    '${platform_normalized}' == '${android_normalized}'    Open Android Application
    ...    ELSE IF    '${platform_normalized}' == '${ios_normalized}'        Open IOS Application
    ...    ELSE       Fail    Invalid platform name: ${PLATFORM_NAME}
    
    # Register automatic screenshot capture on test failure
    Register Keyword To Run On Failure    Capture Failure Screenshot
    
    Log    Application opened successfully on ${PLATFORM_NAME}    INFO


Open Android Application
    [Documentation]    Initialize and open Android application with Appium
    ...                Sets up all required capabilities and timeouts
    
    Open Application    
    ...    ${APPIUM_SERVER_URL}
    ...    automationName=${ANDROID_AUTOMATION_NAME}
    ...    platformName=${ANDROID_PLATFORM_NAME}
    ...    platformVersion=${ANDROID_PLATFORM_VERSION}
    ...    deviceName=${ANDROID_DEVICE_NAME}
    ...    app=${ANDROID_APP}
    ...    appPackage=${ANDROID_APP_PACKAGE}
    ...    appActivity=${ANDROID_APP_ACTIVITY}
    ...    autoGrantPermissions=${AUTO_GRANT_PERMISSIONS}
    ...    noReset=${NO_RESET}
    ...    fullReset=${FULL_RESET}
    ...    newCommandTimeout=${NEW_COMMAND_TIMEOUT}
    
    Set Appium Timeout    ${TIMEOUT}
    Log    Android application opened successfully    INFO


Open IOS Application
    [Documentation]    Initialize and open iOS application with Appium
    ...                Sets up all required capabilities and timeouts
    
    Open Application    
    ...    ${APPIUM_SERVER_URL}
    ...    automationName=${IOS_AUTOMATION_NAME}
    ...    platformName=${IOS_PLATFORM_NAME}
    ...    platformVersion=${IOS_PLATFORM_VERSION}
    ...    deviceName=${IOS_DEVICE_NAME}
    ...    udid=${IOS_DEVICE_UDID}
    ...    app=${IOS_APP}
    ...    bundleId=${IOS_APP_BUNDLE_ID}
    ...    autoAcceptAlerts=${AUTO_ACCEPT_ALERTS}
    ...    showXcodeLog=${IOS_SHOW_IOS_LOG}
    ...    useNewWDA=${IOS_USE_NEW_WDA}
    ...    wdaStartupRetries=${IOS_WDA_STARTUP_RETRIES}
    ...    wdaStartupRetryInterval=${IOS_WDA_STARTUP_RETRY_INTERVAL}
    ...    wdaLaunchTimeout=${IOS_WDA_LAUNCH_TIMEOUT}
    ...    wdaConnectionTimeout=${IOS_WDA_CONNECTION_TIMEOUT}
    ...    derivedDataPath=${IOS_DERIVED_DATA_PATH}
    ...    noReset=${NO_RESET}
    ...    fullReset=${FULL_RESET}
    ...    newCommandTimeout=${NEW_COMMAND_TIMEOUT}
    
    Set Appium Timeout    ${TIMEOUT}
    Log    iOS application opened successfully    INFO


Close Test Application
    [Documentation]    Close the mobile application and cleanup
    [Tags]            teardown    cleanup
    
    Run Keyword And Ignore Error    Stop Video Recording If Running
    Run Keyword And Ignore Error    Close Application
    Log    Application closed successfully    INFO


# ==============================================================================
# Element Interaction Keywords
# ==============================================================================

Wait For Element To Be Visible
    [Documentation]    Wait for element to be visible with retry mechanism
    [Arguments]        ${locator}    ${retry_scale}=${SMALL_RETRY_SCALE}
    
    Wait Until Keyword Succeeds    
    ...    ${retry_scale}    
    ...    ${RETRY_DELAY}    
    ...    Wait Until Element Is Visible    ${locator}    timeout=${TIMEOUT}
    
    Log    Element visible: ${locator}    DEBUG


Wait For Element To Exist
    [Documentation]    Wait for element to exist in DOM with retry mechanism
    [Arguments]        ${locator}    ${retry_scale}=${SMALL_RETRY_SCALE}
    
    Wait Until Keyword Succeeds    
    ...    ${retry_scale}    
    ...    ${RETRY_DELAY}    
    ...    Wait Until Page Contains Element    ${locator}    timeout=${TIMEOUT}
    
    Log    Element exists: ${locator}    DEBUG


Wait For Element To Disappear
    [Documentation]    Wait for element to disappear from screen
    [Arguments]        ${locator}    ${retry_scale}=${SMALL_RETRY_SCALE}
    
    Wait Until Keyword Succeeds    
    ...    ${retry_scale}    
    ...    ${RETRY_DELAY}    
    ...    Wait Until Page Does Not Contain Element    ${locator}    timeout=${TIMEOUT}
    
    Log    Element disappeared: ${locator}    DEBUG


Click On Element
    [Documentation]    Click on element with wait and retry mechanism
    [Arguments]        ${locator}    ${retry_scale}=${SMALL_RETRY_SCALE}
    
    Wait For Element To Be Visible    ${locator}    ${retry_scale}
    Wait Until Keyword Succeeds    
    ...    ${retry_scale}    
    ...    ${RETRY_DELAY}    
    ...    Click Element    ${locator}
    
    Sleep    ${WAIT_AFTER_ACTION}s
    Log    Clicked element: ${locator}    INFO


Input Text Into Field
    [Documentation]    Input text into field with wait and retry mechanism
    ...                Clears existing text before input
    [Arguments]        ${locator}    ${text}    ${retry_scale}=${SMALL_RETRY_SCALE}
    
    Wait For Element To Be Visible    ${locator}    ${retry_scale}
    Wait Until Keyword Succeeds    
    ...    ${retry_scale}    
    ...    ${RETRY_DELAY}    
    ...    Input Text    ${locator}    ${text}
    
    Sleep    ${WAIT_AFTER_ACTION}s
    Log    Input text into field: ${locator}    INFO


Clear Text Field
    [Documentation]    Clear text from input field
    [Arguments]        ${locator}    ${retry_scale}=${SMALL_RETRY_SCALE}
    
    Wait For Element To Be Visible    ${locator}    ${retry_scale}
    Wait Until Keyword Succeeds    
    ...    ${retry_scale}    
    ...    ${RETRY_DELAY}    
    ...    Run Keywords
    ...    Click Element    ${locator}
    ...    AND    Clear Text    ${locator}
    
    Log    Cleared text field: ${locator}    INFO


Get Element Text Value
    [Documentation]    Get text value from element
    [Arguments]        ${locator}    ${retry_scale}=${SMALL_RETRY_SCALE}
    
    Wait For Element To Be Visible    ${locator}    ${retry_scale}
    ${text}=    Get Text    ${locator}
    Log    Element text: ${text}    DEBUG
    RETURN          ${text}


Verify Element Text Equals
    [Documentation]    Verify element text matches expected value
    [Arguments]        ${locator}    ${expected_text}    ${retry_scale}=${SMALL_RETRY_SCALE}
    
    Wait For Element To Be Visible    ${locator}    ${retry_scale}
    Wait Until Keyword Succeeds    
    ...    ${retry_scale}    
    ...    ${RETRY_DELAY}    
    ...    Element Text Should Be    ${locator}    ${expected_text}
    
    Log    Verified element text: ${expected_text}    INFO


Verify Element Is Visible
    [Documentation]    Verify element is visible on screen
    [Arguments]        ${locator}    ${retry_scale}=${SMALL_RETRY_SCALE}
    
    Wait For Element To Be Visible    ${locator}    ${retry_scale}
    Log    Element is visible: ${locator}    INFO


Verify Element Is Not Visible
    [Documentation]    Verify element is not visible on screen
    [Arguments]        ${locator}    ${retry_scale}=${SMALL_RETRY_SCALE}
    
    Wait For Element To Disappear    ${locator}    ${retry_scale}
    Log    Element is not visible: ${locator}    INFO


# ==============================================================================
# Alert/Dialog Keywords
# ==============================================================================

Wait For Alert To Appear
    [Documentation]    Wait for alert dialog to appear
    [Arguments]        ${retry_scale}=${MEDIUM_RETRY_SCALE}
    
    Sleep    2s    # Give alert time to appear
    Log    Waiting for alert to appear    DEBUG


# ==============================================================================
# Utility Keywords
# ==============================================================================

Generate Random Email
    [Documentation]    Generate random email address for testing
    
    ${random_string}=    Generate Random String    10    [LETTERS][NUMBERS]
    ${email}=    Set Variable    test${random_string}@mailinator.com
    Log    Generated email: ${email}    INFO
    RETURN    ${email}


Generate Random String With Length
    [Documentation]    Generate random string with specific length
    [Arguments]        ${length}=10
    
    ${random_string}=    Generate Random String    ${length}    [LETTERS][NUMBERS]
    Log    Generated random string of length ${length}    DEBUG
    RETURN    ${random_string}


Get Current Timestamp
    [Documentation]    Get current timestamp in epoch format
    
    ${timestamp}=    Get Time    epoch
    Log    Current timestamp: ${timestamp}    DEBUG
    RETURN    ${timestamp}


Take Screenshot With Timestamp
    [Documentation]    Take screenshot with timestamp in filename
    [Arguments]        ${prefix}=screenshot
    
    ${timestamp}=    Get Current Timestamp
    ${screenshot_name}=    Set Variable    ${prefix}_${timestamp}
    ${screenshot_path}=    Capture Page Screenshot    ${screenshot_name}.png
    Log    Screenshot saved: ${screenshot_path}    INFO
    RETURN    ${screenshot_path}


Capture Failure Screenshot
    [Documentation]    Capture screenshot on test failure - automatically registered with Appium
    
    ${status}    ${error}=    Run Keyword And Ignore Error    Capture Page Screenshot
    Run Keyword If    '${status}' == 'PASS'    Log    Failure screenshot captured    INFO
    Run Keyword If    '${status}' == 'FAIL'    Log    Could not capture screenshot: ${error}    WARN


Scroll Down
    [Documentation]    Scroll down on the screen
    [Arguments]        ${duration}=${SWIPE_DURATION}
    
    ${screen_size}=    Get Window Size
    ${start_x}=    Evaluate    ${screen_size}[0] * 0.5
    ${start_y}=    Evaluate    ${screen_size}[1] * 0.8
    ${end_x}=      Evaluate    ${screen_size}[0] * 0.5
    ${end_y}=      Evaluate    ${screen_size}[1] * 0.2
    
    Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    ${duration}
    Log    Scrolled down    DEBUG


Scroll Up
    [Documentation]    Scroll up on the screen
    [Arguments]        ${duration}=${SWIPE_DURATION}
    
    ${screen_size}=    Get Window Size
    ${start_x}=    Evaluate    ${screen_size}[0] * 0.5
    ${start_y}=    Evaluate    ${screen_size}[1] * 0.2
    ${end_x}=      Evaluate    ${screen_size}[0] * 0.5
    ${end_y}=      Evaluate    ${screen_size}[1] * 0.8
    
    Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    ${duration}
    Log    Scrolled up    DEBUG


Hide Keyboard
    [Documentation]    Hide the keyboard if visible
    
    Run Keyword And Ignore Error    Hide Keyboard
    Log    Keyboard hidden    DEBUG


# ==============================================================================
# App State Keywords
# ==============================================================================

Put App To Background And Reactivate
    [Documentation]    Put app to background and bring back to foreground
    [Arguments]        ${duration}=5
    
    Background Application    ${duration}
    Log    App sent to background for ${duration} seconds    INFO


Restart Application
    [Documentation]    Close and reopen the application
    
    Close Application
    Sleep    2s
    Open Test Application
    Log    Application restarted    INFO


# ==============================================================================
# Video Recording Keywords
# ==============================================================================

Start Video Recording
    [Documentation]    Start screen recording for the test
    ...                Video will be saved when Stop Video Recording is called
    
    ${status}    ${error}=    Run Keyword And Ignore Error    Start Recording Screen
    Run Keyword If    '${status}' == 'PASS'    Log    Video recording started    INFO
    Run Keyword If    '${status}' == 'FAIL'    Log    Could not start video recording: ${error}    WARN
    Set Suite Variable    ${VIDEO_RECORDING_ACTIVE}    ${status}


Stop Video Recording
    [Documentation]    Stop screen recording and save video file
    [Arguments]        ${video_name}=${TEST_NAME}
    
    ${status}    ${video_data}=    Run Keyword And Ignore Error    Stop Recording Screen
    Run Keyword If    '${status}' == 'PASS'    Save Video File    ${video_data}    ${video_name}
    Run Keyword If    '${status}' == 'FAIL'    Log    Could not stop video recording: ${video_data}    WARN
    Set Suite Variable    ${VIDEO_RECORDING_ACTIVE}    FAIL


Stop Video Recording If Running
    [Documentation]    Stop video recording if it's currently active
    
    ${is_running}=    Get Variable Value    ${VIDEO_RECORDING_ACTIVE}    FAIL
    Run Keyword If    '${is_running}' == 'PASS'    Stop Video Recording    final_video


Save Video File
    [Documentation]    Save base64 video data to file and embed in report
    [Arguments]        ${video_data}    ${video_name}
    
    ${safe_name}=    Replace String    ${video_name}    ${SPACE}    _
    ${safe_name}=    Replace String    ${safe_name}    /    _
    ${safe_name}=    Replace String    ${safe_name}    :    _
    ${video_file}=    Set Variable    ${OUTPUT_DIR}${/}${safe_name}.mp4
    
    # Decode base64 video data and save to file
    TRY
        ${decoded_video}=    Evaluate    base64.b64decode($video_data)    modules=base64
        Create Binary File    ${video_file}    ${decoded_video}
        
        # Embed video in HTML report with relative path
        Log    <video width="800" height="600" controls><source src="${safe_name}.mp4" type="video/mp4">Your browser does not support video.</video>    HTML
        Log    Video saved and embedded in report: ${video_file}    INFO
    EXCEPT    AS    ${error}
        Log    Could not save video file: ${error}    WARN
    END


# ==============================================================================
# Test Execution Keywords with Video
# ==============================================================================

Setup Test With Video
    [Documentation]    Test setup that includes video recording
    ...                Only starts recording if ENABLE_VIDEO_RECORDING is True
    
    Open Test Application
    Run Keyword If    '${ENABLE_VIDEO_RECORDING}' == 'True'    Start Video Recording


Teardown Test With Video
    [Documentation]    Test teardown that stops video and closes app
    ...                Only stops recording if ENABLE_VIDEO_RECORDING is True
    
    Run Keyword If    '${ENABLE_VIDEO_RECORDING}' == 'True'    Stop Video Recording    ${TEST_NAME}
    Close Test Application
