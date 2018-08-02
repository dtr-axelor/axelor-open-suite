package steps;

import cucumber.api.java.en.When;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class WhenDefinitions extends AbsDefinitions {

  /*----------- Helper methods ----------- */

  private void click(String clickType, WebElement button) {
    switch (clickType) {
      case "click on":
        button.click();
        break;
      case "context-click on":
        new Actions(driver).contextClick(button).build().perform();
        break;
      case "double-click on":
        new Actions(driver).doubleClick(button).build().perform();
        break;
    }
  }

  /*----------- WHEN methods ----------- */

  @When("^I" + ACTION_CLICK + " button" + ATTRIBUTE + VALUE + WAIT + "$")
  public void clickOnButton(
      String clickType,
      String attributeName,
      String attributeValue,
      String shouldWait,
      Integer waitingTime)
      throws InterruptedException {

    // new WebDriverWait(driver, 10).until(ExpectedConditions
    // .elementToBeClickable(findElementBy(attributeName, attributeValue,
    // cssSelectorForName)));

    WebElement button = findElementBy(null, attributeName, attributeValue, null);
    click(clickType, button);
    this.wait(shouldWait, waitingTime);
  }

  @When("^I" + ACTION_CLICK + " menu" + ATTRIBUTE + VALUE + WAIT + "$")
  public void clickOnMenu(
      String clickType,
      String attributeName,
      String attributeValue,
      String shouldWait,
      Integer waitingTime)
      throws InterruptedException {
    String cssSelectorForName = ".sidebar li[data-name=" + attributeValue + "] > a";

    // new WebDriverWait(driver, 10).until(ExpectedConditions
    // .elementToBeClickable(findElementBy(attributeName, attributeValue,
    // cssSelectorForName)));

    WebElement menu = findElementBy(null, attributeName, attributeValue, cssSelectorForName);
    click(clickType, menu);

    this.wait(shouldWait, waitingTime);
  }

  @When("^I" + ACTION_CLICK + " tab" + ATTRIBUTE + VALUE + WAIT + "$")
  public void clickOnTab(
      String clickType,
      String attributeName,
      String attributeValue,
      String shouldWait,
      Integer waitingTime)
      throws InterruptedException {
    WebElement tab = findElementBy(null, attributeName, attributeValue, null);
    click(clickType, tab);

    this.wait(shouldWait, waitingTime);
  }

  @When("^I" + ACTION_TYPE + " textbox" + ATTRIBUTE + VALUE + WAIT + "$")
  public void typeInTextbox(
      String fieldValue,
      String attributeName,
      String attributeValue,
      String shouldWait,
      Integer waitingTime) {

    String cssSelectorForName = "[name=" + attributeValue + "] > input";
    WebElement textbox = findElementBy(null, attributeName, attributeValue, cssSelectorForName);
    textbox.clear();
    textbox.sendKeys(fieldValue);

    WebElement currentTextbox =
        findElementBy(null, attributeName, attributeValue, cssSelectorForName);
    new WebDriverWait(driver, 10)
        .until(ExpectedConditions.textToBePresentInElementValue(currentTextbox, fieldValue));

    // wait(shouldWait, waitingTime);
    // Assert.assertEquals("WebDriver issue.", fieldValue, textbox.getText());
  }

  @When("^I" + ACTION_SELECT + " field" + ATTRIBUTE + VALUE + WAIT + "$")
  public void selectFrom(
      String fieldValue,
      String attributeName,
      String attributeValue,
      String shouldWait,
      Integer waitingTime)
      throws InterruptedException {

    String cssSelectorForName = "[name=" + attributeValue + "] > * > input";
    WebElement element = findElementBy(null, attributeName, attributeValue, cssSelectorForName);
    element.clear();
    element.sendKeys(fieldValue);
    Thread.sleep(300);
    element.sendKeys(Keys.ARROW_DOWN);
    element.sendKeys(Keys.ENTER);

    this.wait(shouldWait, waitingTime);
  }

  @When("^I refresh this tab" + WAIT + "$")
  public void refreshTab(String shouldWait, Integer waitingTime) throws InterruptedException {
    WebElement tab = driver.findElement(By.cssSelector("li.active[ng-repeat='tab in navTabs']"));
    new Actions(driver).contextClick(tab).build().perform();

    driver.findElement(By.linkText("Refresh")).click();
  }
}
