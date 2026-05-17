@signup @smoke
Feature: Sign-Up Functionality
  As a new user
  I want to create an account
  So that I can use the application

  Background:
    Given the user is on the signup screen

  # ─────────────────────────────────────────────────────────────
  # Happy-path scenario
  # ─────────────────────────────────────────────────────────────

  @P0 @valid-signup
  Scenario: Successful registration with valid credentials
    When the user signs up with email "newuser@example.com" password "SecurePass123!" and confirm "SecurePass123!"
    Then the signup success alert should be displayed
    And  the signup alert title should contain "You successfully signed up!"
    And  the user dismisses the signup alert

  # ─────────────────────────────────────────────────────────────
  # Validation / error scenarios
  # ─────────────────────────────────────────────────────────────

  @P1 @invalid-email
  Scenario: Signup with an invalid email format shows an email error
    When the user enters signup email "notanemail"
    And  the user enters signup password "SecurePass123!"
    And  the user enters confirm password "SecurePass123!"
    And  the user taps the sign up button
    Then the signup email validation error should be displayed

  @P1 @password-mismatch
  Scenario: Signup with mismatched passwords shows a confirm-password error
    When the user enters signup email "user@example.com"
    And  the user enters signup password "SecurePass123!"
    And  the user enters confirm password "DifferentPass456!"
    And  the user taps the sign up button
    Then the confirm password validation error should be displayed

  @P1 @short-password
  Scenario: Signup with a password shorter than 8 characters shows a password error
    When the user enters signup email "user@example.com"
    And  the user enters signup password "short"
    And  the user enters confirm password "short"
    And  the user taps the sign up button
    Then the signup password validation error should be displayed
