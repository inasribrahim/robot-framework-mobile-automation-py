@login @smoke
Feature: Login
  As a registered user I want to log in so that I can access my account.

  Background:
    Given the user is on the Login screen

  @P0
  Scenario: Successful login with valid credentials
    When  the user enters email "alice@example.com"
    And   the user enters password "SuperSecretPassword!"
    And   the user taps the Login button
    Then  a success alert "You are logged in!" is displayed

  @P1
  Scenario: Login with an invalid email shows an error
    When  the user enters email "not-valid"
    And   the user enters password "SuperSecretPassword!"
    And   the user taps the Login button
    Then  the email validation error is displayed

  @P1
  Scenario: Login with a password shorter than 8 characters shows an error
    When  the user enters email "alice@example.com"
    And   the user enters password "short"
    And   the user taps the Login button
    Then  the password validation error is displayed

  @P2
  Scenario: Navigate from Login to Sign Up
    When  the user taps the Sign Up link
    Then  the Sign Up screen is displayed

  @P1
  Scenario Outline: Login field validation for multiple invalid inputs
    When  the user enters email "<email>"
    And   the user enters password "<password>"
    And   the user taps the Login button
    Then  the <error> validation error is displayed

    Examples:
      | email             | password         | error    |
      | bad-email-format  | SuperSecretPass! | email    |
      | alice@example.com | short            | password |
