*** Variables ***
# Login Screen Locators
# All locators for login screen elements
# Reference: https://docs.robotframework.org/docs/different_libraries/appium

# Container/Screen Identifier
${LOC_LOGIN_CONTAINER}                    accessibility_id=Login-screen

# Navigation
${LOC_LOGIN_TAB}                          accessibility_id=Login

# Input Fields
${LOC_LOGIN_EMAIL_INPUT}                  accessibility_id=input-email
${LOC_LOGIN_PASSWORD_INPUT}               accessibility_id=input-password

# Buttons
${LOC_LOGIN_BUTTON}                       accessibility_id=button-LOGIN
${LOC_LOGIN_SIGNUP_CONTAINER}             accessibility_id=button-sign-up-container

# Error Messages
${LOC_LOGIN_EMAIL_ERROR}                  xpath=//android.widget.TextView[@text='Please enter a valid email address']
${LOC_LOGIN_PASSWORD_ERROR}               xpath=//android.widget.TextView[@text='Please enter at least 8 characters']

# Alert/Dialog Elements
${LOC_LOGIN_ALERT_TITLE}                  id=android:id/alertTitle
${LOC_LOGIN_ALERT_MESSAGE}                id=android:id/message
${LOC_LOGIN_ALERT_OK_BUTTON}              id=android:id/button1

# iOS Specific Locators (if different from Android)
${LOC_LOGIN_EMAIL_INPUT_IOS}              accessibility_id=input-email
${LOC_LOGIN_PASSWORD_INPUT_IOS}           accessibility_id=input-password
${LOC_LOGIN_BUTTON_IOS}                   accessibility_id=button-LOGIN

# Alternative Locator Strategies (for robustness)
${LOC_LOGIN_EMAIL_INPUT_XPATH}            xpath=//android.widget.EditText[@content-desc="input-email"]
${LOC_LOGIN_PASSWORD_INPUT_XPATH}         xpath=//android.widget.EditText[@content-desc="input-password"]
${LOC_LOGIN_BUTTON_XPATH}                 xpath=//android.view.ViewGroup[@content-desc="button-LOGIN"]
