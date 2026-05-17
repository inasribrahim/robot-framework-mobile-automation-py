@signup @smoke
Feature: Sign Up
  As a new user I want to create an account so that I can use the application.

  Background:
    Given the user is on the Sign Up screen

  @P0
  Scenario: Successful registration with valid details
    When  the user enters signup email "newuser@example.com"
    And   the user enters signup password "SecurePass123!"
    And   the user enters confirm password "SecurePass123!"
    And   the user taps the Sign Up button
    Then  a success alert "You successfully signed up!" is displayed

  @P1
  Scenario: Sign up with an invalid email shows an error
    When  the user enters signup email "notanemail"
    And   the user enters signup password "SecurePass123!"
    And   the user enters confirm password "SecurePass123!"
    And   the user taps the Sign Up button
    Then  the email validation error is displayed

  @P1
  Scenario: Sign up with mismatched passwords shows a confirm-password error
    When  the user enters signup email "user@example.com"
    And   the user enters signup password "SecurePass123!"
    And   the user enters confirm password "DifferentPass456!"
    And   the user taps the Sign Up button
    Then  the confirm password validation error is displayed

  @P1
  Scenario: Sign up with a short password shows a password error
    When  the user enters signup email "user@example.com"
    And   the user enters signup password "short"
    And   the user enters confirm password "short"
    And   the user taps the Sign Up button
    Then  the password validation error is displayed
