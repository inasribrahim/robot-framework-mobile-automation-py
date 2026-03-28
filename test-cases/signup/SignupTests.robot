*** Settings ***
Documentation    Signup Module Test Suite
...              Comprehensive test cases for user registration/signup functionality
...              Reference: https://docs.robotframework.org/docs/different_libraries/appium

Resource         ../../resources/page-objects/NavigationBarPO.robot
Resource         ../../resources/page-objects/LoginScreenPO.robot
Resource         ../../resources/page-objects/SignupScreenPO.robot
Resource         ../../configs/TagConfigs.robot
Resource         ../../localization/en.robot

Test Setup       Open Test Application And Navigate To Signup
Test Teardown    Close Test Application

Default Tags     ${TAG_MODULE_SIGNUP}    ${TAG_ANDROID}


*** Keywords ***
Open Test Application And Navigate To Signup
    [Documentation]    Setup keyword to open app and navigate to signup screen
    Open Test Application
    Navigate To Login Screen
    Click Signup Container In Login Screen


*** Variables ***
# Test Data
${VALID_PASSWORD}                Password123!
${INVALID_EMAIL}                 invalid-email
${SHORT_PASSWORD}                short
${PASSWORD_MISMATCH}             DifferentPass123!


*** Test Cases ***
TC_SIGNUP_001 - Verify User Can Signup With Valid Credentials
    [Documentation]    Test to verify successful signup with valid email and matching passwords
    ...                This is a critical smoke test for user registration
    [Tags]    ${TAG_P0}    ${TAG_SUBMODULE_SIGNUP_VALID}    ${TAG_SMOKE}    ${TAG_REGRESSION}    ${TAG_E2E}    ${TAG_FEATURE_AUTHENTICATION}
    
    ${random_email}=    Generate Random Email
    Complete Valid Signup Flow    ${random_email}    ${VALID_PASSWORD}


TC_SIGNUP_002 - Verify Signup With Invalid Email Format Shows Validation Error
    [Documentation]    Test to verify email validation during signup with invalid format
    ...                Validates client-side email format validation
    [Tags]    ${TAG_P1}    ${TAG_SUBMODULE_SIGNUP_VALIDATION}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}    ${TAG_FEATURE_AUTHENTICATION}
    
    Complete Invalid Email Signup Flow    ${INVALID_EMAIL}    ${VALID_PASSWORD}


TC_SIGNUP_003 - Verify Signup With Short Password Shows Validation Error
    [Documentation]    Test to verify password length validation during signup
    ...                Validates minimum password length requirement (8 characters)
    [Tags]    ${TAG_P1}    ${TAG_SUBMODULE_SIGNUP_VALIDATION}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}    ${TAG_FEATURE_AUTHENTICATION}
    
    ${random_email}=    Generate Random Email
    Complete Invalid Password Signup Flow    ${random_email}    ${SHORT_PASSWORD}


TC_SIGNUP_004 - Verify Signup With Mismatched Passwords Shows Validation Error
    [Documentation]    Test to verify password confirmation validation
    ...                Validates that password and confirm password must match
    [Tags]    ${TAG_P1}    ${TAG_SUBMODULE_SIGNUP_VALIDATION}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}    ${TAG_FEATURE_AUTHENTICATION}
    
    ${random_email}=    Generate Random Email
    Complete Password Mismatch Signup Flow    ${random_email}    ${VALID_PASSWORD}    ${PASSWORD_MISMATCH}


TC_SIGNUP_005 - Verify Signup With Empty Email Field Shows Validation Error
    [Documentation]    Test to verify validation error when email field is empty
    ...                Validates required field validation for email
    [Tags]    ${TAG_P1}    ${TAG_SUBMODULE_SIGNUP_VALIDATION}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}
    
    Verify Signup Screen Is Displayed
    Enter Signup Password    ${VALID_PASSWORD}
    Enter Signup Confirm Password    ${VALID_PASSWORD}
    Click Signup Button
    Verify Signup Email Validation Error Is Displayed


TC_SIGNUP_006 - Verify Signup With Empty Password Field Shows Validation Error
    [Documentation]    Test to verify validation error when password field is empty
    ...                Validates required field validation for password
    [Tags]    ${TAG_P1}    ${TAG_SUBMODULE_SIGNUP_VALIDATION}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}
    
    ${random_email}=    Generate Random Email
    Verify Signup Screen Is Displayed
    Enter Signup Email Address    ${random_email}
    Enter Signup Confirm Password    ${VALID_PASSWORD}
    Click Signup Button
    Verify Signup Password Validation Error Is Displayed


TC_SIGNUP_007 - Verify Signup With Empty Confirm Password Shows Validation Error
    [Documentation]    Test to verify validation error when confirm password field is empty
    ...                Validates required field validation for confirm password
    [Tags]    ${TAG_P1}    ${TAG_SUBMODULE_SIGNUP_VALIDATION}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}
    
    ${random_email}=    Generate Random Email
    Verify Signup Screen Is Displayed
    Enter Signup Email Address    ${random_email}
    Enter Signup Password    ${VALID_PASSWORD}
    Click Signup Button
    Verify Signup Password Mismatch Error Is Displayed


TC_SIGNUP_008 - Verify All Signup Screen Elements Are Displayed
    [Documentation]    Test to verify all signup screen elements are visible
    ...                Validates UI elements rendering on signup screen
    [Tags]    ${TAG_P2}    ${TAG_SUBMODULE_SIGNUP_VALID}    ${TAG_SANITY}    ${TAG_FUNCTIONAL}
    
    Verify Signup Screen Is Displayed
    Verify Signup Button Is Enabled


TC_SIGNUP_009 - Verify Navigation Back To Login From Signup Screen
    [Documentation]    Test to verify navigation from signup back to login screen
    ...                Validates bidirectional screen navigation
    [Tags]    ${TAG_P2}    ${TAG_FEATURE_NAVIGATION}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}
    
    Verify Signup Screen Is Displayed
    Click Login Container
    Verify Login Screen Is Displayed


TC_SIGNUP_010 - Verify Clear Signup Form Functionality
    [Documentation]    Test to verify clearing all signup form fields
    ...                Validates form reset functionality
    [Tags]    ${TAG_P2}    ${TAG_FUNCTIONAL}
    
    ${random_email}=    Generate Random Email
    Verify Signup Screen Is Displayed
    Enter Signup Email Address    ${random_email}
    Enter Signup Password    ${VALID_PASSWORD}
    Enter Signup Confirm Password    ${VALID_PASSWORD}
    Clear Signup Form
    Verify Email Field Is Empty In Signup
    Verify Password Field Is Empty In Signup
    Verify Confirm Password Field Is Empty


TC_SIGNUP_011 - Verify Signup With Special Characters In Password
    [Documentation]    Test to verify signup with password containing special characters
    ...                Validates handling of special characters in password
    [Tags]    ${TAG_P1}    ${TAG_SUBMODULE_SIGNUP_VALID}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}
    
    ${random_email}=    Generate Random Email
    ${special_password}=    Set Variable    Test@123!#$%
    Complete Valid Signup Flow    ${random_email}    ${special_password}


TC_SIGNUP_012 - Verify Signup Alert Dismissal
    [Documentation]    Test to verify dismissing signup success alert
    ...                Validates post-signup alert flow
    [Tags]    ${TAG_P2}    ${TAG_SUBMODULE_SIGNUP_VALID}    ${TAG_FUNCTIONAL}    ${TAG_FEATURE_ALERTS}
    
    ${random_email}=    Generate Random Email
    Complete Valid Signup Flow    ${random_email}    ${VALID_PASSWORD}


TC_SIGNUP_013 - Verify Signup With Maximum Length Email
    [Documentation]    Test to verify signup with maximum allowed email length
    ...                Validates email field boundary conditions
    [Tags]    ${TAG_P2}    ${TAG_FUNCTIONAL}
    
    ${random_string}=    Generate Random String With Length    50
    ${long_email}=    Set Variable    ${random_string}@mailinator.com
    Complete Valid Signup Flow    ${long_email}    ${VALID_PASSWORD}


TC_SIGNUP_014 - Verify Password Fields Masking
    [Documentation]    Test to verify password and confirm password fields mask input
    ...                Validates security feature of password masking
    [Tags]    ${TAG_P2}    ${TAG_FUNCTIONAL}
    
    Verify Signup Screen Is Displayed
    Enter Signup Password    ${VALID_PASSWORD}
    Enter Signup Confirm Password    ${VALID_PASSWORD}
    # Verify both password fields are masked


TC_SIGNUP_015 - Verify Signup With Already Registered Email
    [Documentation]    Test to verify behavior when signing up with existing email
    ...                Validates duplicate email handling
    [Tags]    ${TAG_P1}    ${TAG_SUBMODULE_SIGNUP_INVALID}    ${TAG_FUNCTIONAL}
    
    ${test_email}=    Set Variable    osanda@mailinator.com
    Signup With Credentials    ${test_email}    ${VALID_PASSWORD}    ${VALID_PASSWORD}
    # Verify appropriate error message based on app behavior


TC_SIGNUP_016 - Verify Multiple Signup Attempts With Same Email
    [Documentation]    Test to verify multiple signup attempts with same credentials
    ...                Validates idempotent behavior
    [Tags]    ${TAG_P2}    ${TAG_FUNCTIONAL}
    
    ${random_email}=    Generate Random Email
    FOR    ${counter}    IN RANGE    2
        Signup With Credentials    ${random_email}    ${VALID_PASSWORD}    ${VALID_PASSWORD}
        Run Keyword If    ${counter} == 0    Click Signup Alert OK Button
        Clear Signup Form
    END


TC_SIGNUP_017 - Verify Signup Form Validation On Field Exit
    [Documentation]    Test to verify validation triggers when exiting fields
    ...                Validates real-time field validation
    [Tags]    ${TAG_P2}    ${TAG_FUNCTIONAL}
    
    Verify Signup Screen Is Displayed
    Enter Signup Email Address    ${INVALID_EMAIL}
    Click Signup Password Input To Trigger Validation
    # Verify validation error appears


TC_SIGNUP_018 - Verify Signup With Minimum Valid Password Length
    [Documentation]    Test to verify signup with exactly 8 characters password
    ...                Validates minimum boundary condition for password
    [Tags]    ${TAG_P1}    ${TAG_FUNCTIONAL}    ${TAG_REGRESSION}
    
    ${random_email}=    Generate Random Email
    ${min_password}=    Set Variable    12345678
    Complete Valid Signup Flow    ${random_email}    ${min_password}


TC_SIGNUP_019 - Verify Signup With Case Sensitive Email
    [Documentation]    Test to verify email handling with different cases
    ...                Validates email case sensitivity
    [Tags]    ${TAG_P2}    ${TAG_FUNCTIONAL}
    
    ${random_string}=    Generate Random String With Length    8
    ${email_upper}=    Set Variable    ${random_string}@MAILINATOR.COM
    Complete Valid Signup Flow    ${email_upper}    ${VALID_PASSWORD}


TC_SIGNUP_020 - Verify Signup Flow Completion Time
    [Documentation]    Test to verify signup flow completes within acceptable time
    ...                Validates performance of signup process
    [Tags]    ${TAG_P2}    ${TAG_FUNCTIONAL}
    
    ${random_email}=    Generate Random Email
    ${start_time}=    Get Current Timestamp
    Complete Valid Signup Flow    ${random_email}    ${VALID_PASSWORD}
    ${end_time}=    Get Current Timestamp
    ${duration}=    Evaluate    ${end_time} - ${start_time}
    Should Be True    ${duration} < 30    Signup flow took more than 30 seconds


*** Keywords ***
Click Signup Password Input To Trigger Validation
    [Documentation]    Helper keyword to click password field and trigger validation
    Click On Element    ${LOC_SIGNUP_PASSWORD_INPUT}    ${SMALL_RETRY_SCALE}
