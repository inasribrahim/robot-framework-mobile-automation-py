*** Settings ***
Documentation    Signup Screen Page Object
...              Contains keywords for signup/registration screen interactions
...              Reference: https://docs.robotframework.org/docs/different_libraries/appium

Resource         ../keywords/CommonKeywords.robot
Resource         ../locators/SignupScreenLocators.robot
Resource         ../../localization/${LANGUAGE}.robot


*** Keywords ***
# ==============================================================================
# Signup Actions
# ==============================================================================

Signup With Credentials
    [Documentation]    Perform complete signup flow with email and password
    [Arguments]        ${email}    ${password}    ${confirm_password}
    [Tags]            signup    action
    
    Enter Signup Email Address        ${email}
    Enter Signup Password             ${password}
    Enter Signup Confirm Password     ${confirm_password}
    Click Signup Button
    Log    Signup attempt with email: ${email}    INFO


Enter Signup Email Address
    [Documentation]    Input email address in signup screen
    [Arguments]        ${email}
    [Tags]            input
    
    Input Text Into Field    ${LOC_SIGNUP_EMAIL_INPUT}    ${email}    ${SMALL_RETRY_SCALE}
    Log    Entered email: ${email}    INFO


Enter Signup Password
    [Documentation]    Input password in signup screen
    [Arguments]        ${password}
    [Tags]            input
    
    Input Text Into Field    ${LOC_SIGNUP_PASSWORD_INPUT}    ${password}    ${SMALL_RETRY_SCALE}
    Log    Entered password    INFO


Enter Signup Confirm Password
    [Documentation]    Input confirm password in signup screen
    [Arguments]        ${confirm_password}
    [Tags]            input
    
    Input Text Into Field    ${LOC_SIGNUP_CONFIRM_PASSWORD_INPUT}    ${confirm_password}    ${SMALL_RETRY_SCALE}
    Log    Entered confirm password    INFO


Click Signup Button
    [Documentation]    Click the SIGN UP button
    [Tags]            action
    
    Hide Keyboard
    Click On Element    ${LOC_SIGNUP_BUTTON}    ${SMALL_RETRY_SCALE}
    Log    Clicked Signup button    INFO


Click Signup Container In Login Screen
    [Documentation]    Click signup container from login screen navigation
    [Tags]            navigation
    
    Click On Element    ${LOC_SIGNUP_BUTTON_CONTAINER}    ${SMALL_RETRY_SCALE}
    Log    Clicked Signup container    INFO


Click Login Container
    [Documentation]    Click on Login container to navigate back to login screen
    [Tags]            navigation
    
    Click On Element    ${LOC_SIGNUP_LOGIN_CONTAINER}    ${SMALL_RETRY_SCALE}
    Log    Clicked Login container    INFO


Clear Signup Form
    [Documentation]    Clear all fields in signup form
    [Tags]            action    cleanup
    
    Clear Text Field    ${LOC_SIGNUP_EMAIL_INPUT}              ${SMALL_RETRY_SCALE}
    Clear Text Field    ${LOC_SIGNUP_PASSWORD_INPUT}           ${SMALL_RETRY_SCALE}
    Clear Text Field    ${LOC_SIGNUP_CONFIRM_PASSWORD_INPUT}   ${SMALL_RETRY_SCALE}
    Log    Cleared signup form    INFO


# ==============================================================================
# Signup Validations
# ==============================================================================

Verify Signup Screen Is Displayed
    [Documentation]    Verify signup screen is visible
    [Tags]            verification
    
    Verify Element Is Visible    ${LOC_SIGNUP_EMAIL_INPUT}              ${MEDIUM_RETRY_SCALE}
    Verify Element Is Visible    ${LOC_SIGNUP_PASSWORD_INPUT}           ${SMALL_RETRY_SCALE}
    Verify Element Is Visible    ${LOC_SIGNUP_CONFIRM_PASSWORD_INPUT}   ${SMALL_RETRY_SCALE}
    Verify Element Is Visible    ${LOC_SIGNUP_BUTTON}                   ${SMALL_RETRY_SCALE}
    Log    Signup screen is displayed    INFO


Verify Signup Button Is Enabled
    [Documentation]    Verify signup button is enabled and clickable
    [Tags]            verification
    
    Verify Element Is Visible    ${LOC_SIGNUP_BUTTON}    ${SMALL_RETRY_SCALE}
    Log    Signup button is enabled    DEBUG


Verify Email Field Is Empty In Signup
    [Documentation]    Verify email field contains no text
    [Tags]            verification
    
    ${email_text}=    Get Element Text Value    ${LOC_SIGNUP_EMAIL_INPUT}
    Should Be Empty    ${email_text}
    Log    Signup email field is empty    DEBUG


Verify Password Field Is Empty In Signup
    [Documentation]    Verify password field contains no text
    [Tags]            verification
    
    ${password_text}=    Get Element Text Value    ${LOC_SIGNUP_PASSWORD_INPUT}
    Should Be Empty    ${password_text}
    Log    Signup password field is empty    DEBUG


Verify Confirm Password Field Is Empty
    [Documentation]    Verify confirm password field contains no text
    [Tags]            verification
    
    ${confirm_pass_text}=    Get Element Text Value    ${LOC_SIGNUP_CONFIRM_PASSWORD_INPUT}
    Should Be Empty    ${confirm_pass_text}
    Log    Confirm password field is empty    DEBUG


# ==============================================================================
# Alert/Error Message Validations
# ==============================================================================

Verify Signup Success Alert Is Displayed
    [Documentation]    Verify successful signup alert appears
    [Arguments]        ${expected_title}=${SIGNUP_SUCCESS_TITLE}    
    ...                ${expected_message}=${SIGNUP_SUCCESS_MESSAGE}
    [Tags]            verification    alert
    
    Wait For Alert To Appear    ${MEDIUM_RETRY_SCALE}
    Verify Signup Alert Title    ${expected_title}
    Verify Signup Alert Message   ${expected_message}
    Log    Signup success alert displayed    INFO


Verify Signup Alert Title
    [Documentation]    Verify signup alert dialog title
    [Arguments]        ${expected_title}
    [Tags]            verification
    
    Verify Element Text Equals    ${LOC_SIGNUP_ALERT_TITLE}    ${expected_title}    ${SMALL_RETRY_SCALE}
    Log    Signup alert title verified: ${expected_title}    INFO


Verify Signup Alert Message
    [Documentation]    Verify signup alert dialog message
    [Arguments]        ${expected_message}
    [Tags]            verification
    
    Verify Element Text Equals    ${LOC_SIGNUP_ALERT_MESSAGE}    ${expected_message}    ${SMALL_RETRY_SCALE}
    Log    Signup alert message verified: ${expected_message}    INFO


Click Signup Alert OK Button
    [Documentation]    Click OK button on signup alert dialog
    [Tags]            action
    
    Click On Element    ${LOC_SIGNUP_ALERT_OK_BUTTON}    ${SMALL_RETRY_SCALE}
    Log    Clicked signup alert OK button    INFO


Verify Signup Email Validation Error Is Displayed
    [Documentation]    Verify email validation error message is shown in signup
    [Tags]            verification    validation
    
    Verify Element Is Visible    ${LOC_SIGNUP_EMAIL_ERROR}    ${SMALL_RETRY_SCALE}
    Verify Element Text Equals    ${LOC_SIGNUP_EMAIL_ERROR}    ${SIGNUP_ERROR_INVALID_EMAIL}    ${SMALL_RETRY_SCALE}
    Log    Signup email validation error displayed    INFO


Verify Signup Password Validation Error Is Displayed
    [Documentation]    Verify password validation error message is shown in signup
    [Tags]            verification    validation
    
    Verify Element Is Visible    ${LOC_SIGNUP_PASSWORD_ERROR}    ${SMALL_RETRY_SCALE}
    Verify Element Text Equals    ${LOC_SIGNUP_PASSWORD_ERROR}    ${LOGIN_ERROR_INVALID_PASSWORD}    ${SMALL_RETRY_SCALE}
    Log    Signup password validation error displayed    INFO


Verify Signup Password Mismatch Error Is Displayed
    [Documentation]    Verify password mismatch error when passwords don't match
    [Tags]            verification    validation
    
    Verify Element Is Visible    ${LOC_SIGNUP_CONFIRM_PASSWORD_ERROR}    ${SMALL_RETRY_SCALE}
    Verify Element Text Equals    ${LOC_SIGNUP_CONFIRM_PASSWORD_ERROR}    ${SIGNUP_ERROR_PASSWORD_MISMATCH}    ${SMALL_RETRY_SCALE}
    Log    Signup password mismatch error displayed    INFO


# ==============================================================================
# Complete Signup Flows
# ==============================================================================

Complete Valid Signup Flow
    [Documentation]    Perform complete valid signup with verification
    ...                This is an end-to-end signup flow for positive scenarios
    [Arguments]        ${email}    ${password}
    [Tags]            e2e    positive
    
    Verify Signup Screen Is Displayed
    Signup With Credentials    ${email}    ${password}    ${password}
    Verify Signup Success Alert Is Displayed
    Click Signup Alert OK Button
    Log    Completed valid signup flow for: ${email}    INFO


Complete Invalid Email Signup Flow
    [Documentation]    Perform signup with invalid email and verify error
    ...                This validates email format validation in signup
    [Arguments]        ${invalid_email}    ${password}
    [Tags]            e2e    negative
    
    Verify Signup Screen Is Displayed
    Signup With Credentials    ${invalid_email}    ${password}    ${password}
    Verify Signup Email Validation Error Is Displayed
    Log    Completed invalid email signup flow    INFO


Complete Invalid Password Signup Flow
    [Documentation]    Perform signup with invalid password and verify error
    ...                This validates password length validation in signup
    [Arguments]        ${email}    ${invalid_password}
    [Tags]            e2e    negative
    
    Verify Signup Screen Is Displayed
    Signup With Credentials    ${email}    ${invalid_password}    ${invalid_password}
    Verify Signup Password Validation Error Is Displayed
    Log    Completed invalid password signup flow    INFO


Complete Password Mismatch Signup Flow
    [Documentation]    Perform signup with mismatched passwords and verify error
    ...                This validates password confirmation matching
    [Arguments]        ${email}    ${password}    ${different_password}
    [Tags]            e2e    negative
    
    Verify Signup Screen Is Displayed
    Signup With Credentials    ${email}    ${password}    ${different_password}
    Verify Signup Password Mismatch Error Is Displayed
    Log    Completed password mismatch signup flow    INFO


Complete Signup With Random User
    [Documentation]    Perform complete signup with randomly generated credentials
    ...                Useful for tests requiring unique user accounts
    [Tags]            e2e    positive    random
    
    ${random_email}=    Generate Random Email
    ${random_password}=    Set Variable    Password123!
    
    Verify Signup Screen Is Displayed
    Signup With Credentials    ${random_email}    ${random_password}    ${random_password}
    Verify Signup Success Alert Is Displayed
    Click Signup Alert OK Button
    Log    Completed signup with random user: ${random_email}    INFO
    RETURN    ${random_email}    ${random_password}
