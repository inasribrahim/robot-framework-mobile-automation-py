package com.automation.steps;

import com.automation.pages.LoginPage;
import com.automation.pages.SignupPage;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.testng.Assert;

/**
 * Step definitions for the Login feature.
 *
 * Each method maps to a Gherkin step in login.feature.
 * The {@link LoginPage} page object handles all driver interactions so that
 * these steps stay concise and readable.
 */
public class LoginSteps {

    private LoginPage loginPage;
    private SignupPage signupPage;

    // ── Given ──────────────────────────────────────────────────────────────

    @Given("the user is on the login screen")
    public void theUserIsOnTheLoginScreen() {
        // App launches to the Login screen by default; just initialise the page object.
        loginPage = new LoginPage();
    }

    // ── When ───────────────────────────────────────────────────────────────

    @When("the user enters email {string}")
    public void theUserEntersEmail(String email) {
        loginPage.enterEmail(email);
    }

    @When("the user enters password {string}")
    public void theUserEntersPassword(String password) {
        loginPage.enterPassword(password);
    }

    @When("the user taps the login button")
    public void theUserTapsTheLoginButton() {
        loginPage.clickLoginButton();
    }

    @When("the user logs in with email {string} and password {string}")
    public void theUserLogsInWithEmailAndPassword(String email, String password) {
        loginPage.login(email, password);
    }

    @When("the user taps the sign up link from login")
    public void theUserTapsTheSignUpLinkFromLogin() {
        loginPage.clickSignupLink();
        signupPage = new SignupPage();
    }

    // ── Then ───────────────────────────────────────────────────────────────

    @Then("the login success alert should be displayed")
    public void theLoginSuccessAlertShouldBeDisplayed() {
        Assert.assertTrue(loginPage.isSuccessAlertDisplayed(),
                "Expected login success alert to be displayed, but it was not.");
    }

    @Then("the login alert title should contain {string}")
    public void theLoginAlertTitleShouldContain(String expectedText) {
        String actual = loginPage.getAlertTitle();
        Assert.assertTrue(actual.contains(expectedText),
                "Alert title '" + actual + "' does not contain '" + expectedText + "'");
    }

    @Then("the login email validation error should be displayed")
    public void theLoginEmailValidationErrorShouldBeDisplayed() {
        Assert.assertTrue(loginPage.isEmailErrorDisplayed(),
                "Expected email validation error to be displayed, but it was not.");
    }

    @Then("the login password validation error should be displayed")
    public void theLoginPasswordValidationErrorShouldBeDisplayed() {
        Assert.assertTrue(loginPage.isPasswordErrorDisplayed(),
                "Expected password validation error to be displayed, but it was not.");
    }

    @Then("the signup screen should be displayed from login")
    public void theSignupScreenShouldBeDisplayedFromLogin() {
        Assert.assertNotNull(signupPage,
                "SignupPage was null – navigation from Login did not complete.");
    }

    // ── And ────────────────────────────────────────────────────────────────

    @And("the user dismisses the login alert")
    public void theUserDismissesTheLoginAlert() {
        loginPage.dismissAlert();
    }
}
