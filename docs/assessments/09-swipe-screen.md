<p align="center">
  <img src="https://www.cibeg.com/-/media/feature/navigation/footer/logo-white.svg"
       alt="CIB Bank Logo" width="220" style="background:#003366; padding:12px; border-radius:6px;" />
</p>

---

> **📋 This assessment has been assigned to you.**
> Please read the user story and acceptance criteria below, write the Gherkin scenarios, and implement the automation using the tech stack provided.
> **Assessment issued by: CIB — Commercial International Bank**

---

# Assessment 09 — Swipe Screen

## User Story

**As a** mobile app user,
**I want** to swipe through a stack of cards and drag elements into a designated drop zone on the Swipe screen,
**so that** I can interact with gesture-based UI components as I would in a real-world application.

---

## Acceptance Criteria

| # | Criterion |
|---|-----------|
| AC-09.1 | The Swipe screen is displayed when the Swipe tab is tapped |
| AC-09.2 | One or more swipeable cards are visible on the Swipe screen |
| AC-09.3 | Swiping a card to the left removes it from view or reveals content behind it |
| AC-09.4 | Swiping a card to the right removes it from view or reveals content behind it |
| AC-09.5 | A drag-and-drop area is visible on the Swipe screen |
| AC-09.6 | Dragging the designated element into the correct drop zone triggers a visible success indicator |
| AC-09.7 | All cards in the stack are reachable by scrolling or swiping vertically through the list |

---

## Test Scenarios

```gherkin
Feature: Swipe Screen
  As a mobile app user
  I want to swipe cards and drag elements on the Swipe screen
  So that I can interact with gesture-based components

  Background:
    Given the WDIO Native Demo App is installed and launched
    And I tap the "Swipe" navigation tab

  @smoke @P1 @swipe
  Scenario: SW-01 Swipe screen is displayed with cards visible
    Then I should see the "Swipe" screen
    And at least one swipeable card should be visible

  @P1 @swipe @gesture
  Scenario: SW-02 Swiping a card to the left removes it or reveals content
    Given a swipeable card is visible
    When I swipe the card to the left
    Then the card should be removed from view or its content should be revealed

  @P1 @swipe @gesture
  Scenario: SW-03 Swiping a card to the right removes it or reveals content
    Given a swipeable card is visible
    When I swipe the card to the right
    Then the card should be removed from view or its content should be revealed

  @P1 @swipe @drag-drop
  Scenario: SW-04 Dragging the element to the drop zone shows a success indicator
    Given the drag source element is visible
    And the drop zone is visible
    When I drag the source element to the drop zone
    Then a success indicator should be displayed

  @P2 @swipe @gesture
  Scenario: SW-05 All cards are accessible by swiping through the stack
    When I swipe through all the cards in the stack
    Then all cards should have been displayed at least once
    And no error or crash should occur during the swipe sequence
```

---

## Automation Notes

- **Swipe gesture**: Use `PointerInput` with `TOUCH` kind.
  ```java
  PointerInput finger = new PointerInput(PointerInput.Kind.TOUCH, "finger");
  Sequence swipe = new Sequence(finger, 0);
  swipe.addAction(finger.createPointerMove(Duration.ZERO, PointerInput.Origin.viewport(), startX, y));
  swipe.addAction(finger.createPointerDown(PointerInput.MouseButton.LEFT.asArg()));
  swipe.addAction(finger.createPointerMove(Duration.ofMillis(500), PointerInput.Origin.viewport(), endX, y));
  swipe.addAction(finger.createPointerUp(PointerInput.MouseButton.LEFT.asArg()));
  driver.perform(Collections.singletonList(swipe));
  ```
- **Drag and drop**: Use `Actions.dragAndDrop(sourceElement, targetElement).perform()` or coordinate-based `PointerInput`.
- **Success indicator**: Assert that a success `TextView` or icon becomes visible after the drop.
- All gesture helpers should live in `SwipePage.java` — never inline in step definitions.

---

## Deliverables

| # | Item |
|---|------|
| 1 | `features/swipe.feature` — Gherkin file matching the scenarios above |
| 2 | `steps/SwipeSteps.java` — Step definitions for all Swipe steps |
| 3 | `pages/SwipePage.java` — Page Object with all gesture helpers and locators |
| 4 | All scenarios passing with `mvn test -Dcucumber.filter.tags="@swipe"` |
