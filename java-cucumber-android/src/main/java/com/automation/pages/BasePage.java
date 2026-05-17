package com.automation.pages;

import com.automation.driver.DriverManager;
import io.appium.java_client.AppiumBy;
import io.appium.java_client.AppiumDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;

/**
 * Base class for all Page Objects.
 *
 * Provides a shared {@link AppiumDriver}, an explicit {@link WebDriverWait},
 * and convenience helpers for the most common element interactions.
 * Every page object extends this class – never instantiate it directly.
 */
public abstract class BasePage {

    protected final AppiumDriver driver;
    protected final WebDriverWait wait;

    /** Default explicit-wait timeout (seconds). */
    private static final long DEFAULT_TIMEOUT = 15;

    protected BasePage() {
        this.driver = DriverManager.getDriver();
        this.wait   = new WebDriverWait(driver, Duration.ofSeconds(DEFAULT_TIMEOUT));
    }

    // ── Finder helpers ────────────────────────────────────────────────────

    /** Wait for visibility, then return the element found by accessibility id. */
    protected WebElement findByAccessibilityId(String accessibilityId) {
        return wait.until(ExpectedConditions.visibilityOfElementLocated(
                AppiumBy.accessibilityId(accessibilityId)));
    }

    /** Wait for visibility, then return the element found by resource-id. */
    protected WebElement findById(String resourceId) {
        return wait.until(ExpectedConditions.visibilityOfElementLocated(
                AppiumBy.id(resourceId)));
    }

    /** Wait for visibility, then return the element found by XPath. */
    protected WebElement findByXpath(String xpath) {
        return wait.until(ExpectedConditions.visibilityOfElementLocated(
                AppiumBy.xpath(xpath)));
    }

    // ── Action helpers ────────────────────────────────────────────────────

    /** Tap an element. */
    protected void tap(WebElement element) {
        element.click();
    }

    /** Clear then type text into an element. */
    protected void typeText(WebElement element, String text) {
        element.clear();
        element.sendKeys(text);
    }

    /** Return the visible text of an element. */
    protected String getText(WebElement element) {
        return element.getText();
    }

    /**
     * Safely check if an element is currently displayed.
     * Returns {@code false} instead of throwing an exception when the element
     * is not found within the wait timeout.
     */
    protected boolean isDisplayed(String accessibilityId) {
        try {
            return findByAccessibilityId(accessibilityId).isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }
}
