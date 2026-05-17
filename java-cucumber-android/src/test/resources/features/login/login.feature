@login @smoke
Feature: Login Functionality
  As a registered user
  I want to be able to log in to the application
  So that I can access my account

  Background:
    Given the user is on the login screen

  # ─────────────────────────────────────────────────────────────
  # Happy-path scenarios  (must always pass before a release)
  # ─────────────────────────────────────────────────────────────

  @P0 @valid-login
  Scenario: Successful login with valid credentials
    When the user logs in with email "alice@example.com" and password "SuperSecretPassword!"
    Then the login success alert should be displayed
    And  the login alert title should contain "You are logged in!"
    And  the user dismisses the login alert

  # ─────────────────────────────────────────────────────────────
  # Validation / error scenarios
  # ─────────────────────────────────────────────────────────────

  @P1 @invalid-email
  Scenario: Login with an invalid email format shows an email error
    When the user enters email "not-a-valid-email"
    And  the user enters password "SuperSecretPassword!"
    And  the user taps the login button
    Then the login email validation error should be displayed

  @P1 @invalid-password
  Scenario: Login with a password shorter than 8 characters shows a password error
    When the user enters email "alice@example.com"
    And  the user enters password "short"
    And  the user taps the login button
    Then the login password validation error should be displayed

  # ─────────────────────────────────────────────────────────────
  # Navigation scenario
  # ─────────────────────────────────────────────────────────────

  @P2 @navigation
  Scenario: Navigate from login screen to signup screen
    When the user taps the sign up link from login
    Then the signup screen should be displayed from login

  # ─────────────────────────────────────────────────────────────
  # Data-driven scenario (Scenario Outline)
  # ─────────────────────────────────────────────────────────────

  @P1 @data-driven
  Scenario Outline: Login field validations for multiple invalid inputs
    When the user enters email "<email>"
    And  the user enters password "<password>"
    And  the user taps the login button
    Then the login <error_field> validation error should be displayed

    Examples:
      | email                  | password           | error_field |
      | bad-email-format       | SuperSecretPass!   | email       |
      | valid@example.com      | short              | password    |
