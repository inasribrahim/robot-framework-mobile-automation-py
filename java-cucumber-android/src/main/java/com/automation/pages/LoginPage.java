package com.automation.pages;

import io.appium.java_client.AppiumBy;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

/**
 * Page Object for the Login screen of the WDIO Native Demo App.
 *
 * Locator strategy: prefer {@code accessibility_id} (cross-platform, stable)
 * and fall back to XPath only when a system alert ID is required.
 *
 * All public methods return {@code this} to allow fluent chaining:
 * <pre>
 *   loginPage.enterEmail("alice@example.com")
 *            .enterPassword("Secret123!")
 *            .clickLoginButton();
 * </pre>
 */
public class LoginPage extends BasePage {

    // ── Locators ──────────────────────────────────────────────────────────

    private static final String EMAIL_INPUT          = "input-email";
    private static final String PASSWORD_INPUT       = "input-password";
    private static final String LOGIN_BUTTON         = "button-LOGIN";
    private static final String SIGNUP_LINK          = "button-sign-up-container";

    private static final String ALERT_TITLE          = "android:id/alertTitle";
    private static final String ALERT_OK_BUTTON      = "android:id/button1";

    private static final String EMAIL_ERROR_XPATH    =
            "//android.widget.TextView[@text='Please enter a valid email address']";
    private static final String PASSWORD_ERROR_XPATH =
            "//android.widget.TextView[@text='Please enter at least 8 characters']";

    // ── Actions ───────────────────────────────────────────────────────────

    public LoginPage enterEmail(String email) {
        typeText(findByAccessibilityId(EMAIL_INPUT), email);
        return this;
    }

    public LoginPage enterPassword(String password) {
        typeText(findByAccessibilityId(PASSWORD_INPUT), password);
        return this;
    }

    public LoginPage clickLoginButton() {
        tap(findByAccessibilityId(LOGIN_BUTTON));
        return this;
    }

    public LoginPage clickSignupLink() {
        tap(findByAccessibilityId(SIGNUP_LINK));
        return this;
    }

    /**
     * Convenience method: fill credentials and tap Login in one call.
     */
    public LoginPage login(String email, String password) {
        return enterEmail(email).enterPassword(password).clickLoginButton();
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
}
