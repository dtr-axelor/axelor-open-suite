package com.axelor.apps.testing.steps;

import cucumber.api.java.en.Given;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class GivenDefinitions extends AbsDefinitions {

  @Given("^I navigate to \"([^\"]*)\"$")
  public static void navigateTo(String url) {
    driver.navigate().to(url);

    // Wait for app sidebar to appear
    WebDriverWait wait = new WebDriverWait(AbsDefinitions.driver, 40);
    wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector(".sidebar")));
  }
}
