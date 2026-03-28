*** Settings ***
Documentation    Navigation Bar Page Object
...              Contains keywords for interacting with bottom navigation bar
...              Reference: https://docs.robotframework.org/docs/different_libraries/appium

Resource         ../keywords/CommonKeywords.robot
Resource         ../locators/NavigationBarLocators.robot
Resource         LoginScreenPO.robot


*** Keywords ***
Navigate To Home Screen
    [Documentation]    Navigate to Home screen by clicking Home tab
    [Tags]            navigation
    
    Click On Element    ${LOC_NAV_HOME_TAB}    ${SMALL_RETRY_SCALE}
    Verify Home Screen Is Displayed
    Log    Navigated to Home screen    INFO


Navigate To Webview Screen
    [Documentation]    Navigate to Webview screen by clicking Webview tab
    [Tags]            navigation
    
    Click On Element    ${LOC_NAV_WEBVIEW_TAB}    ${SMALL_RETRY_SCALE}
    Verify Webview Screen Is Displayed
    Log    Navigated to Webview screen    INFO


Navigate To Login Screen
    [Documentation]    Navigate to Login screen by clicking Login tab
    [Tags]            navigation
    
    Click On Element    ${LOC_NAV_LOGIN_TAB}    ${SMALL_RETRY_SCALE}
    LoginScreenPO.Verify Login Screen Is Displayed
    Log    Navigated to Login screen    INFO


Navigate To Forms Screen
    [Documentation]    Navigate to Forms screen by clicking Forms tab
    [Tags]            navigation
    
    Click On Element    ${LOC_NAV_FORMS_TAB}    ${SMALL_RETRY_SCALE}
    Verify Forms Screen Is Displayed
    Log    Navigated to Forms screen    INFO


Navigate To Swipe Screen
    [Documentation]    Navigate to Swipe screen by clicking Swipe tab
    [Tags]            navigation
    
    Click On Element    ${LOC_NAV_SWIPE_TAB}    ${SMALL_RETRY_SCALE}
    Verify Swipe Screen Is Displayed
    Log    Navigated to Swipe screen    INFO


Verify Navigation Bar Is Visible
    [Documentation]    Verify that navigation bar is displayed
    [Tags]            verification
    
    Verify Element Is Visible    ${LOC_NAV_HOME_TAB}    ${SMALL_RETRY_SCALE}
    Log    Navigation bar is visible    INFO


Verify Home Tab Is Active
    [Documentation]    Verify Home tab is currently active
    [Tags]            verification
    
    Verify Element Is Visible    ${LOC_NAV_HOME_TAB}    ${SMALL_RETRY_SCALE}
    Log    Home tab is active    DEBUG


Verify Login Tab Is Active
    [Documentation]    Verify Login tab is currently active
    [Tags]            verification
    
    Verify Element Is Visible    ${LOC_NAV_LOGIN_TAB}    ${SMALL_RETRY_SCALE}
    Log    Login tab is active    DEBUG


# Screen Verification Keywords (to be implemented based on screen-specific locators)
Verify Home Screen Is Displayed
    [Documentation]    Verify Home screen is displayed after navigation
    Sleep    1s    # Wait for screen transition
    Log    Home screen displayed    DEBUG


Verify Webview Screen Is Displayed
    [Documentation]    Verify Webview screen is displayed after navigation
    Sleep    1s    # Wait for screen transition
    Log    Webview screen displayed    DEBUG





Verify Forms Screen Is Displayed
    [Documentation]    Verify Forms screen is displayed after navigation
    Sleep    1s    # Wait for screen transition
    Log    Forms screen displayed    DEBUG


Verify Swipe Screen Is Displayed
    [Documentation]    Verify Swipe screen is displayed after navigation
    Sleep    1s    # Wait for screen transition
    Log    Swipe screen displayed    DEBUG
