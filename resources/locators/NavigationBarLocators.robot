*** Variables ***
# Navigation Bar Locators
# All locators for bottom navigation bar elements
# Reference: https://docs.robotframework.org/docs/different_libraries/appium

# Navigation Bar Container
${LOC_NAV_BAR_CONTAINER}                  accessibility_id=navigation-bar

# Navigation Tabs
${LOC_NAV_HOME_TAB}                       accessibility_id=Home
${LOC_NAV_WEBVIEW_TAB}                    accessibility_id=Webview
${LOC_NAV_LOGIN_TAB}                      accessibility_id=Login
${LOC_NAV_FORMS_TAB}                      accessibility_id=Forms
${LOC_NAV_SWIPE_TAB}                      accessibility_id=Swipe

# Tab Icons (if needed for verification)
${LOC_NAV_HOME_ICON}                      xpath=//android.widget.TextView[@text="Home"]
${LOC_NAV_WEBVIEW_ICON}                   xpath=//android.widget.TextView[@text="Webview"]
${LOC_NAV_LOGIN_ICON}                     xpath=//android.widget.TextView[@text="Login"]
${LOC_NAV_FORMS_ICON}                     xpath=//android.widget.TextView[@text="Forms"]
${LOC_NAV_SWIPE_ICON}                     xpath=//android.widget.TextView[@text="Swipe"]

# iOS Specific Locators (if different from Android)
${LOC_NAV_HOME_TAB_IOS}                   accessibility_id=Home
${LOC_NAV_WEBVIEW_TAB_IOS}                accessibility_id=Webview
${LOC_NAV_LOGIN_TAB_IOS}                  accessibility_id=Login
${LOC_NAV_FORMS_TAB_IOS}                  accessibility_id=Forms
${LOC_NAV_SWIPE_TAB_IOS}                  accessibility_id=Swipe

# Alternative XPath Locators
${LOC_NAV_HOME_TAB_XPATH}                 xpath=//android.widget.TextView[@text="Home"]
${LOC_NAV_LOGIN_TAB_XPATH}                xpath=//android.widget.TextView[@text="Login"]
