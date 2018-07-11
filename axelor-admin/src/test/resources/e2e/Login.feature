@Login
Feature: Login and setting language from French to English

  Scenario: Login
    Given I open the site "/login.jsp"
    When I type "admin" in field with id "usernameId"
    And I type "admin" in field with id "passwordId"
    And I click on button with type "submit"
    Then I wait for app UI

  Scenario: Change language
    When I open the site "/#/preferences"
    And I wait for data loading
    And I select "English" from field with name "Language"
    And I click on button with selector ".user-preferences-footer > div > button:first-child"
