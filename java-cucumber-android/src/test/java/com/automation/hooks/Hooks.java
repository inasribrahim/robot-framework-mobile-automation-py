package com.automation.hooks;

import com.automation.config.CapabilitiesConfig;
import com.automation.driver.DriverManager;
import io.appium.java_client.android.AndroidDriver;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;
import io.qameta.allure.Allure;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;

import java.io.ByteArrayInputStream;
import java.net.URL;

/**
 * Cucumber lifecycle hooks – run before / after every scenario.
 *
 * Responsibilities:
 *   • @Before  – Create and store the AndroidDriver in DriverManager.
 *   • @After   – Capture a screenshot on failure (attached to Allure report),
 *                then quit the driver to free resources.
 */
public class Hooks {

    @Before(order = 0)
    public void setUp(Scenario scenario) throws Exception {
        AndroidDriver driver = new AndroidDriver(
                new URL(CapabilitiesConfig.getAppiumUrl()),
                CapabilitiesConfig.getAndroidOptions()
        );
        DriverManager.setDriver(driver);
    }

    @After(order = 0)
    public void tearDown(Scenario scenario) {
        if (scenario.isFailed()) {
            captureScreenshot(scenario);
        }
        DriverManager.quitDriver();
    }

    // ── helpers ────────────────────────────────────────────────────────────

    private void captureScreenshot(Scenario scenario) {
        try {
            byte[] screenshot = ((TakesScreenshot) DriverManager.getDriver())
                    .getScreenshotAs(OutputType.BYTES);

            // Attach to Cucumber HTML report
            scenario.attach(screenshot, "image/png", "Screenshot on Failure");

            // Attach to Allure report
            Allure.addAttachment("Screenshot on Failure",
                    "image/png",
                    new ByteArrayInputStream(screenshot),
                    "png");

        } catch (Exception e) {
            System.err.println("[Hooks] Could not capture screenshot: " + e.getMessage());
        }
    }
}
