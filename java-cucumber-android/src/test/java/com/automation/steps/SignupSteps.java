package com.automation.steps;

import com.automation.pages.LoginPage;
import com.automation.pages.SignupPage;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.testng.Assert;

/**
 * Step definitions for the Sign-Up feature.
 */
public class SignupSteps {

    private SignupPage signupPage;

    // ── Given ──────────────────────────────────────────────────────────────

    @Given("the user is on the signup screen")
    public void theUserIsOnTheSignupScreen() {
        // The app opens to the Login screen; navigate to Signup by tapping the sign-up link.
        LoginPage loginPage = new LoginPage();
        loginPage.clickSignupLink();
        signupPage = new SignupPage();
    }

    // ── When ───────────────────────────────────────────────────────────────

    @When("the user enters signup email {string}")
    public void theUserEntersSignupEmail(String email) {
        signupPage.enterEmail(email);
    }

    @When("the user enters signup password {string}")
    public void theUserEntersSignupPassword(String password) {
        signupPage.enterPassword(password);
    }

    @When("the user enters confirm password {string}")
    public void theUserEntersConfirmPassword(String confirmPassword) {
        signupPage.enterConfirmPassword(confirmPassword);
    }

    @When("the user taps the sign up button")
    public void theUserTapsTheSignUpButton() {
        signupPage.clickSignupButton();
    }

    @When("the user signs up with email {string} password {string} and confirm {string}")
    public void theUserSignsUpWithEmailPasswordAndConfirm(String email, String password, String confirm) {
        signupPage.signup(email, password, confirm);
    }

    // ── Then ───────────────────────────────────────────────────────────────

    @Then("the signup success alert should be displayed")
    public void theSignupSuccessAlertShouldBeDisplayed() {
        Assert.assertTrue(signupPage.isSuccessAlertDisplayed(),
                "Expected signup success alert to be displayed, but it was not.");
    }

    @Then("the signup alert title should contain {string}")
    public void theSignupAlertTitleShouldContain(String expectedText) {
        String actual = signupPage.getAlertTitle();
        Assert.assertTrue(actual.contains(expectedText),
                "Alert title '" + actual + "' does not contain '" + expectedText + "'");
    }

    @Then("the signup email validation error should be displayed")
    public void theSignupEmailValidationErrorShouldBeDisplayed() {
        Assert.assertTrue(signupPage.isEmailErrorDisplayed(),
                "Expected signup email validation error, but it was not displayed.");
    }

    @Then("the signup password validation error should be displayed")
    public void theSignupPasswordValidationErrorShouldBeDisplayed() {
        Assert.assertTrue(signupPage.isPasswordErrorDisplayed(),
                "Expected signup password validation error, but it was not displayed.");
    }

    @Then("the confirm password validation error should be displayed")
    public void theConfirmPasswordValidationErrorShouldBeDisplayed() {
        Assert.assertTrue(signupPage.isConfirmPasswordErrorDisplayed(),
                "Expected confirm-password validation error, but it was not displayed.");
    }

    // ── And ────────────────────────────────────────────────────────────────

    @And("the user dismisses the signup alert")
    public void theUserDismissesTheSignupAlert() {
        signupPage.dismissAlert();
    }
}
