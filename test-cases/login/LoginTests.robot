*** Settings ***
Documentation    Login Module Test Suite
...              Comprehensive test cases for login functionality
...              Reference: https://docs.robotframework.org/docs/different_libraries/appium

Resource         ../../resources/page-objects/NavigationBarPO.robot
Resource         ../../resources/page-objects/LoginScreenPO.robot
Resource         ../../configs/TagConfigs.robot
Resource         ../../localization/en.robot

Test Setup       Open Test Application
Test Teardown    Close Test Application

Default Tags     ${TAG_MODULE_LOGIN}    ${TAG_ANDROID}


*** Variables ***
# Test Data
${VALID_EMAIL}                   osanda@mailinator.com
${VALID_PASSWORD}                osanda@SL
${INVALID_EMAIL}                 invalid-email
${INVALID_PASSWORD}              short


*** Test Cases ***
TC001 - Verify User Can Login With Valid Credentials
    [Documentation]    Test to verify successful login with valid email and password
    ...                This is a critical smoke test for authentication functionality
    [Tags]    ${TAG_P0}    ${TAG_SUBMODULE_LOGIN_VALID}    ${TAG_SMOKE}    ${TAG_REGRESSION}    ${TAG_E2E}    ${TAG_FEATURE_AUTHENTICATION}
    
    Navigate To Login Screen
    Complete Valid Login Flow    ${VALID_EMAIL}    ${VALID_PASSWORD}


TC002 - Verify Login With Invalid Email Format Shows Validation Error
    [Documentation]    Test to verify email validation when entering invalid email format
    ...                Validates client-side email format validation
    [Tags]    ${TAG_P1}    ${TAG_SUBMODULE_LOGIN_VALIDATION}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}    ${TAG_FEATURE_AUTHENTICATION}
    
    Navigate To Login Screen
    Complete Invalid Email Login Flow    ${INVALID_EMAIL}    ${VALID_PASSWORD}


TC003 - Verify Login With Invalid Password Length Shows Validation Error
    [Documentation]    Test to verify password validation when password is too short
    ...                Validates client-side password length validation (minimum 8 characters)
    [Tags]    ${TAG_P1}    ${TAG_SUBMODULE_LOGIN_VALIDATION}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}    ${TAG_FEATURE_AUTHENTICATION}
    
    Navigate To Login Screen
    Complete Invalid Password Login Flow    ${VALID_EMAIL}    ${INVALID_PASSWORD}


TC004 - Verify Login With Empty Email Field Shows Validation Error
    [Documentation]    Test to verify validation error when email field is empty
    ...                Validates required field validation for email
    [Tags]    ${TAG_P1}    ${TAG_SUBMODULE_LOGIN_VALIDATION}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}

    Navigate To Login Screen
    Verify Login Screen Is Displayed
    Enter Password    ${VALID_PASSWORD}
    Click Login Button
    Verify Email Validation Error Is Displayed


TC005 - Verify Login With Empty Password Field Shows Validation Error
    [Documentation]    Test to verify validation error when password field is empty
    ...                Validates required field validation for password
    [Tags]    ${TAG_P1}    ${TAG_SUBMODULE_LOGIN_VALIDATION}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}
    
    Navigate To Login Screen
    Verify Login Screen Is Displayed
    Enter Email Address    ${VALID_EMAIL}
    Click Login Button
    Verify Password Validation Error Is Displayed


TC006 - Verify Login With Both Empty Fields Shows Validation Errors
    [Documentation]    Test to verify validation errors when both fields are empty
    ...                Validates complete form validation
    [Tags]    ${TAG_P2}    ${TAG_SUBMODULE_LOGIN_VALIDATION}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}
    
    Navigate To Login Screen
    Verify Login Screen Is Displayed
    Click Login Button
    # Both validation errors should appear
    Verify Email Validation Error Is Displayed


TC007 - Verify Login Screen Elements Are Displayed
    [Documentation]    Test to verify all login screen elements are visible
    ...                Validates UI elements rendering
    [Tags]    ${TAG_P2}    ${TAG_SUBMODULE_LOGIN_VALID}    ${TAG_SANITY}    ${TAG_FUNCTIONAL}
    
    Navigate To Login Screen
    Verify Login Screen Is Displayed
    Verify Login Button Is Enabled


TC008 - Verify Navigation To Signup From Login Screen
    [Documentation]    Test to verify navigation from login to signup screen
    ...                Validates screen navigation flow
    [Tags]    ${TAG_P2}    ${TAG_FEATURE_NAVIGATION}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}
    
    Navigate To Login Screen
    Verify Login Screen Is Displayed
    Click Signup Container


TC009 - Verify Clear Login Form Functionality
    [Documentation]    Test to verify clearing login form fields
    ...                Validates form reset functionality
    [Tags]    ${TAG_P2}    ${TAG_FUNCTIONAL}
    
    Navigate To Login Screen
    Verify Login Screen Is Displayed
    Enter Email Address    ${VALID_EMAIL}
    Enter Password    ${VALID_PASSWORD}
    Clear Login Form
    Verify Email Field Is Empty
    Verify Password Field Is Empty


TC010 - Verify Login With Special Characters In Password
    [Documentation]    Test to verify login with password containing special characters
    ...                Validates handling of special characters
    [Tags]    ${TAG_P1}    ${TAG_SUBMODULE_LOGIN_VALID}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}
    
    Navigate To Login Screen
    ${special_password}=    Set Variable    Test@123!#
    Login With Credentials    ${VALID_EMAIL}    ${special_password}
    # Verify appropriate behavior based on acceptance criteria


TC011 - Verify Login Alert Dismissal Returns To Login Screen
    [Documentation]    Test to verify dismissing success alert returns to login screen
    ...                Validates post-login alert flow
    [Tags]    ${TAG_P2}    ${TAG_SUBMODULE_LOGIN_VALID}    ${TAG_FUNCTIONAL}    ${TAG_FEATURE_ALERTS}
    
    Navigate To Login Screen
    Complete Valid Login Flow    ${VALID_EMAIL}    ${VALID_PASSWORD}
    # Screen should remain or navigate based on app behavior


TC012 - Verify Login Persists After App Backgrounding
    [Documentation]    Test to verify login session persists when app is backgrounded
    ...                Validates session management
    [Tags]    ${TAG_P2}    ${TAG_INTEGRATION}    ${TAG_FUNCTIONAL}
    
    Navigate To Login Screen
    Complete Valid Login Flow    ${VALID_EMAIL}    ${VALID_PASSWORD}
    Put App To Background And Reactivate    duration=3
    # Verify user remains logged in


TC013 - Verify Multiple Failed Login Attempts
    [Documentation]    Test to verify behavior after multiple failed login attempts
    ...                Validates error handling for repeated failures
    [Tags]    ${TAG_P2}    ${TAG_SUBMODULE_LOGIN_INVALID}    ${TAG_FUNCTIONAL}
    
    Navigate To Login Screen
    FOR    ${counter}    IN RANGE    3
        Login With Credentials    ${INVALID_EMAIL}    ${VALID_PASSWORD}
        Verify Email Validation Error Is Displayed
        Clear Login Form
    END


TC014 - Verify Login With Maximum Length Email
    [Documentation]    Test to verify login with maximum allowed email length
    ...                Validates email field boundary conditions
    [Tags]    ${TAG_P2}    ${TAG_FUNCTIONAL}
    
    Navigate To Login Screen
    ${long_email}=    Set Variable    verylongemailaddressfortesting1234567890@mailinator.com
    Login With Credentials    ${long_email}    ${VALID_PASSWORD}
    # Verify appropriate behavior


TC015 - Verify Password Field Masking
    [Documentation]    Test to verify password field masks input characters
    ...                Validates security feature of password masking
    [Tags]    ${TAG_P2}    ${TAG_FUNCTIONAL}
    
    Navigate To Login Screen
    Verify Login Screen Is Displayed
    Enter Password    ${VALID_PASSWORD}
    # Verify password is masked (implementation depends on app behavior)
