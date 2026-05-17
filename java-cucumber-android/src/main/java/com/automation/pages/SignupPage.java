package com.automation.pages;

import io.appium.java_client.AppiumBy;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

/**
 * Page Object for the Sign-Up screen of the WDIO Native Demo App.
 */
public class SignupPage extends BasePage {

    // ── Locators ──────────────────────────────────────────────────────────

    private static final String EMAIL_INPUT                  = "input-email";
    private static final String PASSWORD_INPUT               = "input-password";
    private static final String CONFIRM_PASSWORD_INPUT       = "input-repeat-password";
    private static final String SIGNUP_BUTTON                = "button-SIGN UP";
    private static final String LOGIN_LINK                   = "button-login-container";

    private static final String ALERT_TITLE                  = "android:id/alertTitle";
    private static final String ALERT_OK_BUTTON              = "android:id/button1";

    private static final String EMAIL_ERROR_XPATH            =
            "//android.widget.TextView[@text='Please enter a valid email address']";
    private static final String PASSWORD_ERROR_XPATH         =
            "//android.widget.TextView[@text='Please enter at least 8 characters']";
    private static final String CONFIRM_PASSWORD_ERROR_XPATH =
            "//android.widget.TextView[@text='Please enter the same password']";

    // ── Actions ───────────────────────────────────────────────────────────

    public SignupPage enterEmail(String email) {
        typeText(findByAccessibilityId(EMAIL_INPUT), email);
        return this;
    }

    public SignupPage enterPassword(String password) {
        typeText(findByAccessibilityId(PASSWORD_INPUT), password);
        return this;
    }

    public SignupPage enterConfirmPassword(String confirmPassword) {
        typeText(findByAccessibilityId(CONFIRM_PASSWORD_INPUT), confirmPassword);
        return this;
    }

    public SignupPage clickSignupButton() {
        tap(findByAccessibilityId(SIGNUP_BUTTON));
        return this;
    }

    public SignupPage clickLoginLink() {
        tap(findByAccessibilityId(LOGIN_LINK));
        return this;
    }

    /**
     * Convenience method: fill all signup fields and tap Sign Up.
     */
    public SignupPage signup(String email, String password, String confirmPassword) {
        return enterEmail(email)
                .enterPassword(password)
                .enterConfirmPassword(confirmPassword)
                .clickSignupButton();
    }

    // ── Assertions / Queries ──────────────────────────────────────────────

    public boolean isSuccessAlertDisplayed() {
        try {
            WebElement alert = wait.until(ExpectedConditions.visibilityOfElementLocated(
                    AppiumBy.id(ALERT_TITLE)));
            return alert.isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }

    public String getAlertTitle() {
        return getText(findById(ALERT_TITLE));
    }

    public void dismissAlert() {
        tap(findById(ALERT_OK_BUTTON));
    }

    public boolean isEmailErrorDisplayed() {
        try {
            return findByXpath(EMAIL_ERROR_XPATH).isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isPasswordErrorDisplayed() {
        try {
            return findByXpath(PASSWORD_ERROR_XPATH).isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isConfirmPasswordErrorDisplayed() {
        try {
            return findByXpath(CONFIRM_PASSWORD_ERROR_XPATH).isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }
}
