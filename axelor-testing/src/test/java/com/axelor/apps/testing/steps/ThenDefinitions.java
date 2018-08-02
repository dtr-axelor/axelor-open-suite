package com.axelor.apps.testing.steps;

import cucumber.api.PendingException;
import cucumber.api.java.en.Then;
import java.util.List;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;

public class ThenDefinitions extends AbsDefinitions {

  /*----------- Helper methods ----------- */

  private WebElement getActiveStatusElement(WebElement element) {
    String classList = element.getAttribute("class");
    if (classList.contains("nav-select")) {
      return element.findElement(By.cssSelector(".nav-step.active > a"));
    } else if (classList.contains("radio-select")) {
      return element.findElement(By.cssSelector("[checked='checked'] ~ span:last-child"));
    } else if (classList.contains("checkbox-select")) {
      // TODO
      throw new PendingException();
    } else if (classList.contains("select-progress")) {
      // TODO
      throw new PendingException();
    } else {
      throw new IllegalArgumentException("This widget does not represent a status.");
    }
  }

  /*----------- THEN methods ----------- */

  @Then(
      "^the"
          + WIDGET_ORDINAL
          + " field"
          + ATTRIBUTE
          + VALUE
          + " should have value"
          + VALUE
          + WAIT
          + "$")
  public void checkFieldValue(
      Integer ordinal,
      String locatingMechanism,
      String attributeValue,
      String expectedValue,
      String shouldWait,
      Integer waitingTime)
      throws InterruptedException {
    WebElement element = findElementBy(ordinal, locatingMechanism, attributeValue, null);
    if (locatingMechanism.equals("name")) {
      element = element.findElement(By.cssSelector("input"));
    }

    String actualValue;
    String elementTagName = element.getTagName();
    if (elementTagName.equals("input") || elementTagName.equals("select")) {
      actualValue = element.getAttribute("value");
    } else {
      actualValue = element.getText();
    }

    Assert.assertTrue(
        "Check if a field has the expected value.\nExpected: "
            + expectedValue
            + "\nActual: "
            + actualValue,
        actualValue.equals(expectedValue));

    this.wait(shouldWait, waitingTime);
  }

  @Then(
      "^the"
          + WIDGET_ORDINAL
          + " pop-up"
          + ATTRIBUTE
          + VALUE
          + " should have value"
          + VALUE
          + WAIT
          + "$")
  public void checkPopupText(
      Integer ordinal,
      String locatingMechanism,
      String attributeValue,
      String expectedValue,
      String shouldWait,
      Integer waitingTime)
      throws InterruptedException {
    WebElement element = findElementBy(ordinal, locatingMechanism, attributeValue, null);
    String actualValue = element.getText();

    Assert.assertTrue(
        "Check if a pop-up has the expected text.\nExpected: "
            + expectedValue
            + "\nActual: "
            + actualValue,
        actualValue.equals(expectedValue));

    this.wait(shouldWait, waitingTime);
  }

  @Then("^the status" + ATTRIBUTE + VALUE + " should be" + VALUE + "$")
  public void checkStatus(String attributeName, String attributeValue, String expectedStatus)
      throws InterruptedException {

    // WebDriverWait driverWait = new WebDriverWait(driver, 10);
    // driverWait.until(ExpectedConditions.textToBePresentInElementValue(
    // getActiveStatusElement(findElementBy(attributeName, attributeValue,
    // cssSelectorForName)),
    // expectedStatus));

    WebElement element = findElementBy(null, attributeName, attributeValue, null);
    String actualStatus = getActiveStatusElement(element).getText();

    Assert.assertTrue(
        "Check if a field has the expected status.\nExpected: "
            + expectedStatus
            + "\nActual: "
            + actualStatus,
        actualStatus.equals(expectedStatus));
  }

  @Then(
      "^the"
          + WIDGET_ORDINAL
          + " (field|panel|tab)"
          + ATTRIBUTE
          + VALUE
          + " should be"
          + PROPERTY
          + "$")
  public void checkQualifier(
      Integer ordinal,
      String object,
      String attributeName,
      String attributeValue,
      String expectedProperty) {
    boolean hasQualifier = false;

    try {
      @SuppressWarnings("unused")
      WebElement element = findElementBy(ordinal, attributeName, attributeValue, null);
      switch (expectedProperty) {
        case "visible":
          // if the element wasn't visible, we could not have accessed it
          // with findElementBy method
          hasQualifier = true;
          break;
        case "TODO":
          // TODO: write other cases
          throw new PendingException();
        default:
          throw new IllegalArgumentException("You cannot check this property.");
      }
    } catch (NoSuchElementException e) {
      if (expectedProperty.equals("invisible")) {
        hasQualifier = true;
      } else {
        throw new NoSuchElementException("The element could not be located.");
      }
    }

    Assert.assertTrue(
        "Check if a field has the expected property.\nExpected: " + expectedProperty, hasQualifier);
  }

  @Then("^the field" + ATTRIBUTE + VALUE + " should have (\\d+) elements$")
  public void checkNumOfElements(
      String attributeName, String attributeValue, int expectedElementCount) {
    List<WebElement> elements = driver.findElements(By.cssSelector(attributeValue));

    Integer actualElementCount = elements.size();
    Assert.assertTrue(
        "Check if a field has the expected number of elements.\nExpected: "
            + expectedElementCount
            + "\nActual: "
            + actualElementCount,
        actualElementCount.equals(expectedElementCount));
  }

  @Then("^a notification with text" + VALUE + " should appear$")
  public void checkNotificationDisplay(String expectedNotificationMessage) {
    throw new PendingException();
    // TODO: use correct selector
    /*
     * WebElement notification = driver.findElement(By.cssSelector("TODO")); String
     * actualNotificationMessage = notification.getText();
     * Assert.assertTrue("Check if notification is displayed correctly",
     * actualNotificationMessage.equals(expectedNotificationMessage));
     */
  }
}
