package steps;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class AbsDefinitions {

  public static final String BASE_URL = "http://web:8080/";
  static WebDriver driver;

  static {
    String driverType = "Chrome headless"; // Change driver type here

    System.setProperty("webdriver.chrome.driver", "/chromedriver");
    switch (driverType) {
      case "Chrome":
        driver = new ChromeDriver();
        break;
      case "Chrome headless":
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        driver = new ChromeDriver(chromeOptions);
        break;
    }

    driver.manage().window().maximize();

    AbsDefinitions.logIn("admin", "admin");
    //		AbsDefinitions.setLanguage("Anglais");
  }

  public static void logIn(String username, String password) {
    driver.navigate().to(BASE_URL + "/login.jsp");

    // Login
    WebElement usernameElement = driver.findElement(By.cssSelector("[name='username']"));
    usernameElement.sendKeys(username);
    WebElement passwordElement = driver.findElement(By.cssSelector("[name='password']"));
    passwordElement.sendKeys(password);
    WebElement loginButton = driver.findElement(By.cssSelector("[type='submit']"));
    loginButton.click();

    // Wait for app sidebar to appear
    WebDriverWait wait = new WebDriverWait(AbsDefinitions.driver, 40);
    wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector(".sidebar")));
  }

  @Deprecated
  public static void setLanguage(String language) {
    driver.navigate().to(BASE_URL + "/#/preferences");

    // Change language
    WebElement languageElement =
        driver.findElement(By.cssSelector("[name='language'] > span > input"));
    languageElement.clear();
    languageElement.sendKeys(language);
    languageElement.sendKeys(Keys.ARROW_DOWN);
    languageElement.sendKeys(Keys.ENTER);

    // Save and close
    WebElement saveButton =
        driver.findElement(By.cssSelector(".user-preferences-footer > div > button:nth-child(1)"));
    saveButton.click();
    WebElement closeButton =
        driver.findElement(By.cssSelector(".user-preferences-footer > div > button:nth-child(2)"));
    closeButton.click();
  }

  /*----------- Patterns ----------- */

  static final String ACTION_CLICK = " ((?:context-|double-)?click on)";
  static final String ACTION_DOUBLE_CLICK = " double-click on";
  static final String ACTION_TYPE = " type" + AbsDefinitions.VALUE + " in";
  static final String ACTION_SELECT = " select" + AbsDefinitions.VALUE + " from";
  static final String ACTION_DRAG_FROM = " drag" + AbsDefinitions.VALUE + " from";
  static final String ACTION_DROP_TO = " drop to";

  static final String WIDGET_ORDINAL =
      "(?: (\\d+)(?:st|nd|rd|th))?"; // 1 argument, not used for the moment
  static final String ATTRIBUTE = " with (name|xpath|selector)"; // 1 argument
  static final String VALUE = " \"([^\"]*)\""; // 1 argument
  static final String PROPERTY = " ([^\"]*)"; // 1 argument
  static final String WAIT = "( and wait(?: for (\\d+) seconds?)?)?"; // 2 arguments

  static final String LOCATING_MECANISM_NAME = "name";
  static final String LOCATING_MECANISM_XPATH = "xpath";
  static final String LOCATING_MECANISM_SELECTOR = "selector";
  protected static final String NAME_CSS_SELECTOR = "[name=%s]";

  /*----------- Utilities methods ----------- */

  protected WebElement findElementBy(
      Integer ordinal, String locatingMechanism, String attributeValue, String cssSelectorForName) {
    if (locatingMechanism == null) {
      throw new IllegalArgumentException("You need to provide a locating mechanism.");
    }
    int index = (ordinal != null) ? ordinal - 1 : 0;

    switch (locatingMechanism) {
      case AbsDefinitions.LOCATING_MECANISM_NAME:
        if (cssSelectorForName == null) {
          cssSelectorForName = String.format(AbsDefinitions.NAME_CSS_SELECTOR, attributeValue);
        }
        return driver.findElements(By.cssSelector(cssSelectorForName)).get(index);
      case AbsDefinitions.LOCATING_MECANISM_XPATH:
        return driver.findElements(By.xpath(attributeValue)).get(index);
      case AbsDefinitions.LOCATING_MECANISM_SELECTOR:
        return driver.findElements(By.cssSelector(attributeValue)).get(index);
      default:
        throw new IllegalArgumentException("Invalid attribute name: " + locatingMechanism);
    }
  }

  protected void wait(String shouldWait, Integer secondsToWait) throws InterruptedException {
    WebDriverWait driverWait = new WebDriverWait(AbsDefinitions.driver, 30);
    driverWait.until(
        ExpectedConditions.invisibilityOfElementLocated(By.cssSelector(".loading-counter")));

    //		long millisecondsToWait = shouldWait == null ? 100 : (secondsToWait == null ? 1000 :
    // secondsToWait * 1000);
    long millisecondsToWait = secondsToWait == null ? 1000 : secondsToWait * 1000;
    Thread.sleep(millisecondsToWait);
  }
}
