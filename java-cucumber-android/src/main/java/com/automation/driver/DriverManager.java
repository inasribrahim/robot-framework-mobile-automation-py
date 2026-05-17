package com.automation.driver;

import io.appium.java_client.AppiumDriver;
import io.appium.java_client.android.AndroidDriver;

/**
 * Manages a single Appium driver instance per thread.
 *
 * Using ThreadLocal makes it safe to run tests in parallel (each thread gets
 * its own driver) while still allowing step definitions to share the same
 * driver within a single scenario.
 */
public class DriverManager {

    /** One driver per thread. */
    private static final ThreadLocal<AppiumDriver> driverHolder = new ThreadLocal<>();

    // ── prevent instantiation ──────────────────────────────────────────────
    private DriverManager() {}

    /** Returns the driver for the current thread (may be {@code null} if not yet set). */
    public static AppiumDriver getDriver() {
        return driverHolder.get();
    }

    /**
     * Convenience cast – returns the driver as an {@link AndroidDriver}.
     * Only call this when you know the driver was created for Android.
     */
    public static AndroidDriver getAndroidDriver() {
        return (AndroidDriver) driverHolder.get();
    }

    /** Stores the driver for the current thread. Called from {@code Hooks.setUp()}. */
    public static void setDriver(AppiumDriver driver) {
        driverHolder.set(driver);
    }

    /**
     * Quits the driver and removes it from the ThreadLocal.
     * Called from {@code Hooks.tearDown()} to prevent memory leaks.
     */
    public static void quitDriver() {
        AppiumDriver driver = driverHolder.get();
        if (driver != null) {
            try {
                driver.quit();
            } catch (Exception e) {
                System.err.println("[DriverManager] Error while quitting driver: " + e.getMessage());
            } finally {
                driverHolder.remove();
            }
        }
    }
}
