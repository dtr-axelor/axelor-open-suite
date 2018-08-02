package com.axelor.apps.testing.runner;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

// format = {"pretty", "html:target/cucumber"}
@RunWith(Cucumber.class)
@CucumberOptions(
  tags = {"@Test"},
  features = "src/test/resources/features",
  glue = "com.axelor.apps.testing.steps"
)
public class TestRunner {}
