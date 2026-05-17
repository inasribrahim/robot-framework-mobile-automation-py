package com.automation.runners;

import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import org.testng.annotations.DataProvider;

/**
 * TestNG entry point that drives Cucumber scenarios.
 *
 * Tags can be overridden at runtime via system property:
 *   mvn test -Dcucumber.filter.tags="@smoke"
 *
 * Reports generated:
 *   • target/cucumber-reports/cucumber.html  – Cucumber native HTML
 *   • target/allure-results/                 – JSON results for Allure
 *     → run `mvn allure:report` to build the full Allure HTML report
 */
@CucumberOptions(
        features = "src/test/resources/features",
        glue     = {"com.automation.hooks", "com.automation.steps"},
        plugin   = {
                "pretty",
                "html:target/cucumber-reports/cucumber.html",
                "json:target/cucumber-reports/cucumber.json",
                "io.qameta.allure.cucumber7jvm.AllureCucumber7Jvm"
        },
        tags     = "not @ignore",
        monochrome = true
)
public class TestRunner extends AbstractTestNGCucumberTests {

    /**
     * Expose scenarios as a TestNG DataProvider.
     * Set parallel = true here (and update testng.xml) to run scenarios in parallel.
     */
    @Override
    @DataProvider(parallel = false)
    public Object[][] scenarios() {
        return super.scenarios();
    }
}
