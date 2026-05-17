<p align="center">
  <img src="https://www.cibeg.com/-/media/feature/navigation/footer/logo-white.svg"
       alt="CIB Bank Logo" width="220" style="background:#003366; padding:12px; border-radius:6px;" />
</p>

---

> **📋 This assessment has been assigned to you.**
> Please read the user story and acceptance criteria below, write the Gherkin scenarios, and implement the automation using the tech stack provided.
> **Assessment issued by: CIB — Commercial International Bank**

---

# Assessment 08 — Forms Screen

## User Story

**As a** mobile app user,
**I want** to interact with various form controls — a text input, a toggle switch, a dropdown, and a slider — on the Forms screen,
**so that** I can enter data and adjust settings in the application.

---

## Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-08.1 | The Forms screen is displayed when the Forms tab is tapped |
| AC-08.2 | A text input field is visible and the user can type text into it |
| AC-08.3 | Clearing the text input field empties it completely |
| AC-08.4 | A toggle switch is visible; tapping it when OFF changes it to ON |
| AC-08.5 | Tapping the toggle switch when ON changes it back to OFF |
| AC-08.6 | A dropdown (spinner/picker) is visible; tapping it shows a list of options |
| AC-08.7 | Selecting an option from the dropdown displays that option as the selected value |
| AC-08.8 | A slider is visible and can be dragged to a new horizontal position |
| AC-08.9 | Controls that support an active/inactive state correctly toggle that state |

---

## Test Scenarios

```gherkin
Feature: Forms Screen
  As a mobile app user
  I want to interact with form controls on the Forms screen
  So that I can enter and adjust data within the app

  Background:
    Given the WDIO Native Demo App is installed and launched
    And I tap the "Forms" navigation tab

  @smoke @P1 @forms
  Scenario: F-01 Forms screen is displayed when the Forms tab is tapped
    Then I should see the "Forms" screen
    And the text input field should be visible
    And the toggle switch should be visible

  @P1 @forms
  Scenario: F-02 User can type text into the text input field
    When I tap the text input field
    And I type "Hello CIB"
    Then the text input field should display "Hello CIB"

  @P1 @forms
  Scenario: F-03 Clearing the text input empties the field
    Given I have typed "Hello CIB" in the text input field
    When I clear the text input field
    Then the text input field should be empty

  @P1 @forms @toggle
  Scenario: F-04 Toggle switch changes from OFF to ON
    Given the toggle switch is in the OFF state
    When I tap the toggle switch
    Then the toggle switch should be in the ON state

  @P1 @forms @toggle
  Scenario: F-05 Toggle switch changes from ON to OFF
    Given the toggle switch is in the ON state
    When I tap the toggle switch
    Then the toggle switch should be in the OFF state

  @P1 @forms @dropdown
  Scenario: F-06 User can select an option from the dropdown
    When I tap the dropdown control
    Then a list of options should be displayed
    When I select the option "Option 2"
    Then the dropdown should show "Option 2" as the selected value

  @P2 @forms @slider
  Scenario: F-07 Slider can be dragged to a new position
    Given I can see the slider on the Forms screen
    When I drag the slider thumb to 75% of its track
    Then the slider value should reflect the new position

  @P2 @forms
  Scenario: F-08 Active and inactive control toggle their state correctly
    Given an activatable control is in its initial state
    When I change its state
    Then the control should reflect the updated state
```

---

## Automation Notes

- **Toggle state**: Assert using the `checked` attribute (`element.getAttribute("checked")`).
- **Slider drag**: Use `TouchAction` or `PointerInput` with `moveTo` coordinates calculated as `(trackStartX + trackWidth * percentage, trackCenterY)`.
- **Dropdown**: The dropdown may be a native Android `Spinner`. Use `click()` on the spinner, then `findElement(By.xpath, "//android.widget.CheckedTextView[@text='Option 2']")` to select.
- All form controls should be accessed through `FormsPage.java` — no direct driver calls in step definitions.

---

## Deliverables

| # | Item |
|---|------|
| 1 | `features/forms.feature` — Gherkin file matching the scenarios above |
| 2 | `steps/FormsSteps.java` — Step definitions for all Forms steps |
| 3 | `pages/FormsPage.java` — Page Object with all locators and actions |
| 4 | All scenarios passing with `mvn test -Dcucumber.filter.tags="@forms"` |
