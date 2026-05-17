package com.automation.config;

import io.appium.java_client.android.options.UiAutomator2Options;

import java.io.InputStream;
import java.time.Duration;
import java.util.Properties;

/**
 * Centralises Appium capabilities and connection settings.
 *
 * Values are resolved in this order (highest priority first):
 *   1. JVM system property  (-Dkey=value passed on the command line)
 *   2. src/test/resources/config.properties
 *   3. Hard-coded default
 */
public class CapabilitiesConfig {

    private static final Properties props = new Properties();

    static {
        try (InputStream is = CapabilitiesConfig.class
                .getClassLoader()
                .getResourceAsStream("config.properties")) {
            if (is != null) {
                props.load(is);
            }
        } catch (Exception e) {
            System.err.println("[CapabilitiesConfig] Could not load config.properties – using defaults. " + e.getMessage());
        }
    }

    /** Returns the Appium server URL (default: http://localhost:4723). */
    public static String getAppiumUrl() {
        return get("appium.url", "http://localhost:4723");
    }

    /** Builds UiAutomator2Options for the Android emulator / device. */
    public static UiAutomator2Options getAndroidOptions() {
        UiAutomator2Options options = new UiAutomator2Options();

        options.setDeviceName(get("device.name", "Android Emulator"));
        options.setPlatformVersion(get("platform.version", "13"));
        options.setAppPackage(get("app.package", "com.wdiodemoapp"));
        options.setAppActivity(get("app.activity", ".MainActivity"));
        options.setAutomationName("UIAutomator2");
        options.setAutoGrantPermissions(true);
        options.setNoReset(false);
        options.setNewCommandTimeout(Duration.ofSeconds(300));

        // Optional: path to the APK.  Leave empty to launch an already-installed app.
        String appPath = get("app.path", "");
        if (!appPath.isEmpty()) {
            options.setApp(appPath);
        }

        return options;
    }

    // ── helpers ─────────────────────────────────────────────────────────────

    private static String get(String key, String defaultValue) {
        // JVM system property wins, then config.properties, then default
        String sysProp = System.getProperty(key);
        if (sysProp != null && !sysProp.isEmpty()) {
            return sysProp;
        }
        return props.getProperty(key, defaultValue);
    }
}
