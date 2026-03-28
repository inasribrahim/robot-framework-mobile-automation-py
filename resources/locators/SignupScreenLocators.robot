*** Variables ***
# Signup Screen Locators
# All locators for signup/registration screen elements
# Reference: https://docs.robotframework.org/docs/different_libraries/appium

# Container/Screen Identifier
${LOC_SIGNUP_CONTAINER}                   accessibility_id=Signup-screen
${LOC_SIGNUP_BUTTON_CONTAINER}            accessibility_id=button-sign-up-container

# Input Fields
${LOC_SIGNUP_EMAIL_INPUT}                 accessibility_id=input-email
${LOC_SIGNUP_PASSWORD_INPUT}              accessibility_id=input-password
${LOC_SIGNUP_CONFIRM_PASSWORD_INPUT}      accessibility_id=input-repeat-password

# Buttons
${LOC_SIGNUP_BUTTON}                      accessibility_id=button-SIGN UP
${LOC_SIGNUP_LOGIN_CONTAINER}             accessibility_id=button-login-container

# Error Messages
${LOC_SIGNUP_EMAIL_ERROR}                 xpath=//android.widget.TextView[@text='Please enter a valid email address']
${LOC_SIGNUP_PASSWORD_ERROR}              xpath=//android.widget.TextView[@text='Please enter at least 8 characters']
${LOC_SIGNUP_CONFIRM_PASSWORD_ERROR}      xpath=//android.widget.TextView[@text='Please enter the same password']

# Alert/Dialog Elements
${LOC_SIGNUP_ALERT_TITLE}                 id=android:id/alertTitle
${LOC_SIGNUP_ALERT_MESSAGE}               id=android:id/message
${LOC_SIGNUP_ALERT_OK_BUTTON}             id=android:id/button1

# iOS Specific Locators (if different from Android)
${LOC_SIGNUP_EMAIL_INPUT_IOS}             accessibility_id=input-email
${LOC_SIGNUP_PASSWORD_INPUT_IOS}          accessibility_id=input-password
${LOC_SIGNUP_CONFIRM_PASSWORD_INPUT_IOS}  accessibility_id=input-repeat-password
${LOC_SIGNUP_BUTTON_IOS}                  accessibility_id=button-SIGN UP

# Alternative Locator Strategies (for robustness)
${LOC_SIGNUP_EMAIL_INPUT_XPATH}           xpath=//android.widget.EditText[@content-desc="input-email"]
${LOC_SIGNUP_PASSWORD_INPUT_XPATH}        xpath=//android.widget.EditText[@content-desc="input-password"]
${LOC_SIGNUP_CONFIRM_PASSWORD_XPATH}      xpath=//android.widget.EditText[@content-desc="input-repeat-password"]
${LOC_SIGNUP_BUTTON_XPATH}                xpath=//android.view.ViewGroup[@content-desc="button-SIGN UP"]
