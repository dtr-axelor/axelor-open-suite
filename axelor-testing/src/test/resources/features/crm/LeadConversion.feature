@Test @LeadConversion
Feature: Lead conversion
  Test processes related to conversion of a lead into a partner/contact

  @Passed
  Scenario: Initialisation with a simple lead
    Given I navigate to "http://localhost:8080/axelor-erp/"
    When I click on menu with name "crm-root" and wait for 1 second
    And I click on menu with name "crm-root-lead" and wait for 1 second
    And I click on button with selector "div.navbar.record-toolbar > div > div > div.btn-group > [title='New']" and wait for 1 second
    And I type "Smith" in textbox with name "name" and wait
    And I click on button with name "start" and wait for 4 second
    And I click on button with name "convert" and wait for 3 seconds

  @Passed
  Scenario: Convert a lead which is not an existing partner or contact and is an individual
    When I select "Individual" from field with name "partnerTypeSelect" and wait for 1 second
    Then the 1st field with name "name" should have value "Smith"
    And the field with name "isProspect" should have value "on"

  @Passed
  Scenario: Convert a lead which is an existing partner or contact
    When I select "Select existing partner" from field with name "'$leadToPartnerSelect'" and wait for 1 second
    And I select "APOLLO" from field with name "'$selectPartner'" and wait for 1 second
    Then the 2nd field with name "name" should have value "Smith"

  @Passed
  Scenario: Validate lead conversion
    When I click on button with name "validate" and wait for 2 seconds
    And I click on button with xpath "//button[contains(text(), 'OK')]" and wait for 2 seconds
    Then the pop-up with selector "div.message-box.ui-dialog-content.ui-widget-content" should have value "Lead converted"
    When I click on button with xpath "//button[contains(text(), 'OK')]" and wait for 2 seconds
    Then the tab with xpath "//span[@ui-tab-popover][contains(text(), 'Customer')]" should be visible
    And the 4th field with selector "div.slick-cell.l2" should have value "Smith"
    And the field with selector "[name='contactPartnerSet'] > div:last-child > div > div.slick-viewport > div > div" should have 4 elements

  @Passed
  Scenario: Check lead conversion
    When I click on tab with xpath "//span[@ui-tab-popover][contains(text(), 'Lead')]"
    And I refresh this tab
    Then the status with name "statusSelect" should be "Converted"
    And the button with name "showPartner" should be visible

  Scenario: Display partner linked with a lead
    When I click on button with name "showPartner"
    Then the 4th field with selector "div.slick-cell.l2" should have value "Smith"

  Scenario: Show report of a lead
    When I click on tab with xpath "//span[@ui-tab-popover][contains(text(), 'Lead')]"
    And I click on button with xpath "//span[contains(text(), 'Reports')]"
    And I click on button with xpath "//a[@ng-click][contains(text(), 'Print')]"
    Then the report with name "Smith" should be visible

  Scenario: Create an event from a lead
    When I click on tab with xpath "//span[@ui-tab-popover][contains(text(), 'Lead')]"
    And I click on button with xpath "//span[contains(text(), 'Tools')]"
    And I click on button with xpath "//a[not(contains(@class, 'disabled'))][contains(text(), 'Schedule Event')]" and wait for 4 seconds
    Then the field with name "lead" should have value "Smith"
    And the field with name "partner" should have value "APOLLO"
