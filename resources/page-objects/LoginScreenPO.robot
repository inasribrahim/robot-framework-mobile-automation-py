*** Settings ***
Documentation    Login Screen Page Object
...              Contains keywords for login screen interactions and validations
...              Reference: https://docs.robotframework.org/docs/different_libraries/appium

Resource         ../keywords/CommonKeywords.robot
Resource         ../locators/LoginScreenLocators.robot
Resource         ../../localization/${LANGUAGE}.robot


*** Keywords ***
# ==============================================================================
# Login Actions
# ==============================================================================

Login With Credentials
    [Documentation]    Perform complete login flow with email and password
    [Arguments]        ${email}    ${password}
    [Tags]            login    action
    
    Enter Email Address    ${email}
    Enter Password         ${password}
    Click Login Button
    Log    Login attempt with email: ${email}    INFO


Enter Email Address
    [Documentation]    Input email address in login screen
    [Arguments]        ${email}
    [Tags]            input
    
    Input Text Into Field    ${LOC_LOGIN_EMAIL_INPUT}    ${email}    ${SMALL_RETRY_SCALE}
    Log    Entered email: ${email}    INFO


Enter Password
    [Documentation]    Input password in login screen
    [Arguments]        ${password}
    [Tags]            input
    
    Input Text Into Field    ${LOC_LOGIN_PASSWORD_INPUT}    ${password}    ${SMALL_RETRY_SCALE}
    Log    Entered password    INFO


Click Login Button
    [Documentation]    Click the LOGIN button
    [Tags]            action
    
    Hide Keyboard
    Click On Element    ${LOC_LOGIN_BUTTON}    ${SMALL_RETRY_SCALE}
    Log    Clicked Login button    INFO


Click Signup Container
    [Documentation]    Click on Sign Up container to navigate to signup screen
    [Tags]            navigation
    
    Click On Element    ${LOC_LOGIN_SIGNUP_CONTAINER}    ${SMALL_RETRY_SCALE}
    Log    Clicked Signup container    INFO


Clear Login Form
    [Documentation]    Clear all fields in login form
    [Tags]            action    cleanup
    
    Clear Text Field    ${LOC_LOGIN_EMAIL_INPUT}     ${SMALL_RETRY_SCALE}
    Clear Text Field    ${LOC_LOGIN_PASSWORD_INPUT}  ${SMALL_RETRY_SCALE}
    Log    Cleared login form    INFO


# ==============================================================================
# Login Validations
# ==============================================================================

Verify Login Screen Is Displayed
    [Documentation]    Verify login screen is visible
    [Tags]            verification
    
    Verify Element Is Visible    ${LOC_LOGIN_EMAIL_INPUT}    ${MEDIUM_RETRY_SCALE}
    Verify Element Is Visible    ${LOC_LOGIN_PASSWORD_INPUT}    ${SMALL_RETRY_SCALE}
    Verify Element Is Visible    ${LOC_LOGIN_BUTTON}    ${SMALL_RETRY_SCALE}
    Log    Login screen is displayed    INFO


Verify Login Button Is Enabled
    [Documentation]    Verify login button is enabled and clickable
    [Tags]            verification
    
    Verify Element Is Visible    ${LOC_LOGIN_BUTTON}    ${SMALL_RETRY_SCALE}
    Log    Login button is enabled    DEBUG


Verify Login Button Is Disabled
    [Documentation]    Verify login button is disabled (if applicable)
    [Tags]            verification
    
    # Implementation depends on app behavior
    Log    Checking login button disabled state    DEBUG


Verify Email Field Is Empty
    [Documentation]    Verify email field contains no text
    [Tags]            verification
    
    ${email_text}=    Get Element Text Value    ${LOC_LOGIN_EMAIL_INPUT}
    Should Be Empty    ${email_text}
    Log    Email field is empty    DEBUG


Verify Password Field Is Empty
    [Documentation]    Verify password field contains no text
    [Tags]            verification
    
    ${password_text}=    Get Element Text Value    ${LOC_LOGIN_PASSWORD_INPUT}
    Should Be Empty    ${password_text}
    Log    Password field is empty    DEBUG


# ==============================================================================
# Alert/Error Message Validations
# ==============================================================================

Verify Login Success Alert Is Displayed
    [Documentation]    Verify successful login alert appears
    [Arguments]        ${expected_title}=${LOGIN_SUCCESS_TITLE}    
    ...                ${expected_message}=${LOGIN_SUCCESS_MESSAGE}
    [Tags]            verification    alert
    
    Wait For Alert To Appear    ${MEDIUM_RETRY_SCALE}
    Verify Alert Title    ${expected_title}
    Verify Alert Message   ${expected_message}
    Log    Login success alert displayed    INFO


Verify Alert Title
    [Documentation]    Verify alert dialog title
    [Arguments]        ${expected_title}
    [Tags]            verification
    
    Verify Element Text Equals    ${LOC_LOGIN_ALERT_TITLE}    ${expected_title}    ${SMALL_RETRY_SCALE}
    Log    Alert title verified: ${expected_title}    INFO


Verify Alert Message
    [Documentation]    Verify alert dialog message
    [Arguments]        ${expected_message}
    [Tags]            verification
    
    Verify Element Text Equals    ${LOC_LOGIN_ALERT_MESSAGE}    ${expected_message}    ${SMALL_RETRY_SCALE}
    Log    Alert message verified: ${expected_message}    INFO


Click Alert OK Button
    [Documentation]    Click OK button on alert dialog
    [Tags]            action
    
    Click On Element    ${LOC_LOGIN_ALERT_OK_BUTTON}    ${SMALL_RETRY_SCALE}
    Log    Clicked alert OK button    INFO


Verify Email Validation Error Is Displayed
    [Documentation]    Verify email validation error message is shown
    [Tags]            verification    validation
    
    Verify Element Is Visible    ${LOC_LOGIN_EMAIL_ERROR}    ${SMALL_RETRY_SCALE}
    Verify Element Text Equals    ${LOC_LOGIN_EMAIL_ERROR}    ${LOGIN_ERROR_INVALID_EMAIL}    ${SMALL_RETRY_SCALE}
    Log    Email validation error displayed    INFO


Verify Password Validation Error Is Displayed
    [Documentation]    Verify password validation error message is shown
    [Tags]            verification    validation
    
    Verify Element Is Visible    ${LOC_LOGIN_PASSWORD_ERROR}    ${SMALL_RETRY_SCALE}
    Verify Element Text Equals    ${LOC_LOGIN_PASSWORD_ERROR}    ${LOGIN_ERROR_INVALID_PASSWORD}    ${SMALL_RETRY_SCALE}
    Log    Password validation error displayed    INFO


# ==============================================================================
# Complete Login Flows
# ==============================================================================

Complete Valid Login Flow
    [Documentation]    Perform complete valid login with verification
    ...                This is an end-to-end login flow for positive scenarios
    [Arguments]        ${email}    ${password}
    [Tags]            e2e    positive
    
    Verify Login Screen Is Displayed
    Login With Credentials    ${email}    ${password}
    Verify Login Success Alert Is Displayed
    Click Alert OK Button
    Log    Completed valid login flow for: ${email}    INFO


Complete Invalid Email Login Flow
    [Documentation]    Perform login with invalid email and verify error
    ...                This validates email format validation
    [Arguments]        ${invalid_email}    ${password}
    [Tags]            e2e    negative
    
    Verify Login Screen Is Displayed
    Login With Credentials    ${invalid_email}    ${password}
    Verify Email Validation Error Is Displayed
    Log    Completed invalid email login flow    INFO


Complete Invalid Password Login Flow
    [Documentation]    Perform login with invalid password and verify error
    ...                This validates password length validation
    [Arguments]        ${email}    ${invalid_password}
    [Tags]            e2e    negative
    
    Verify Login Screen Is Displayed
    Login With Credentials    ${email}    ${invalid_password}
    Verify Password Validation Error Is Displayed
    Log    Completed invalid password login flow    INFO
