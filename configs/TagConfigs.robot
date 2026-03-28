*** Variables ***
# Tag Configuration File
# This file defines all testing tags used in the framework for categorization and filtering
# Reference: https://docs.robotframework.org/docs/different_libraries/appium

# ============================================================================
# PRIORITY TAGS
# ============================================================================
# P0: Critical/Blocker - Must pass for release
# P1: High Priority - Important for release
# P2: Medium Priority - Should pass but not blocking
# P3: Low Priority - Nice to have

${TAG_P0}                         P0
${TAG_P1}                         P1
${TAG_P2}                         P2
${TAG_P3}                         P3

# ============================================================================
# MODULE TAGS
# ============================================================================
${TAG_MODULE_LOGIN}               Module:Login
${TAG_MODULE_SIGNUP}              Module:Signup
${TAG_MODULE_HOME}                Module:Home
${TAG_MODULE_PROFILE}             Module:Profile
${TAG_MODULE_FORMS}               Module:Forms
${TAG_MODULE_SWIPE}               Module:Swipe
${TAG_MODULE_WEBVIEW}             Module:Webview

# ============================================================================
# SUB-MODULE TAGS
# ============================================================================
# Login Sub-modules
${TAG_SUBMODULE_LOGIN_VALID}      SubModule:ValidLogin
${TAG_SUBMODULE_LOGIN_INVALID}    SubModule:InvalidLogin
${TAG_SUBMODULE_LOGIN_VALIDATION}    SubModule:LoginValidation

# Signup Sub-modules
${TAG_SUBMODULE_SIGNUP_VALID}     SubModule:ValidSignup
${TAG_SUBMODULE_SIGNUP_INVALID}   SubModule:InvalidSignup
${TAG_SUBMODULE_SIGNUP_VALIDATION}    SubModule:SignupValidation

# ============================================================================
# TEST TYPE TAGS
# ============================================================================
${TAG_SMOKE}                      Smoke
${TAG_REGRESSION}                 Regression
${TAG_SANITY}                     Sanity
${TAG_FUNCTIONAL}                 Functional
${TAG_E2E}                        E2E
${TAG_INTEGRATION}                Integration

# ============================================================================
# PLATFORM TAGS
# ============================================================================
${TAG_ANDROID}                    Android
${TAG_IOS}                        iOS
${TAG_BOTH_PLATFORMS}             Android_iOS

# ============================================================================
# STATUS TAGS
# ============================================================================
${TAG_READY}                      Ready
${TAG_WIP}                        WIP
${TAG_BLOCKED}                    Blocked
${TAG_DEPRECATED}                 Deprecated

# ============================================================================
# FEATURE TAGS
# ============================================================================
${TAG_FEATURE_AUTHENTICATION}     Feature:Authentication
${TAG_FEATURE_NAVIGATION}         Feature:Navigation
${TAG_FEATURE_FORMS}              Feature:Forms
${TAG_FEATURE_ALERTS}             Feature:Alerts
${TAG_FEATURE_GESTURES}           Feature:Gestures

# ============================================================================
# TAG COMBINATIONS FOR COMMON SCENARIOS
# ============================================================================
# Critical Authentication Tests
@{TAGS_CRITICAL_AUTH}             ${TAG_P0}    ${TAG_MODULE_LOGIN}    ${TAG_SMOKE}    ${TAG_REGRESSION}

# Login Regression Tests
@{TAGS_LOGIN_REGRESSION}          ${TAG_MODULE_LOGIN}    ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}

# Signup Regression Tests
@{TAGS_SIGNUP_REGRESSION}         ${TAG_MODULE_SIGNUP}   ${TAG_REGRESSION}    ${TAG_FUNCTIONAL}

# Full Regression Suite
@{TAGS_FULL_REGRESSION}           ${TAG_REGRESSION}

# Smoke Test Suite
@{TAGS_SMOKE_SUITE}               ${TAG_SMOKE}
