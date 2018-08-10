@Lead @Test
Feature: Lead
  Test processes related to lead object

  @Passed
  Scenario: Create a lead
    When I click on menu with name "crm-root"
    And I click on menu with name "crm-root-lead"
    And I click on button with selector "div.navbar.record-toolbar > div > div > div.btn-group > [title='New']"
    Then the status with name "statusSelect" should be "New"

  @Passed
  Scenario: Start a lead without filling a name
    When I type "" in textbox with name "name"
    And I click on button with name "start"
    Then the status with name "statusSelect" should be "New"
    And a notification with text "The following fields are invalid: Last name" should appear

  @Passed
  Scenario: Assign a lead to someone else
    When I type "Smith" in textbox with name "name"
    And I type "whatever@axelor.com" in textbox with name "address"
    And I select "Daniel SILVA" from field with name "user"
    And I click on button with selector "div.navbar.record-toolbar > div > div > div.btn-group > [title='Save']"
    Then the status with name "statusSelect" should be "Assigned"

  @Passed
  Scenario: Assign a lead to me
    When I click on button with name "grabLead"
    Then the status with name "statusSelect" should be "Assigned"
    And the field with name "user" should have value "Admin"

  @Failed
  Scenario: Start a lead
    When I click on button with name "start"
    Then the status with name "statusSelect" should be "In progress"

  @Failed
  Scenario: Lose a lead
    When I click on button with name "lose"
    #This assumes that the lost reason has been added through CRM config menu
    And I select "Project cancelled" from field with selector "[name='lostReason'] > span > input"
    And I click on button with name "lostReasonConfirm"
    Then the status with name "statusSelect" should be "Lost"
    And the field with selector "[name='lostReason'] > span > a" should have value "Project cancelled"

  @Failed
  Scenario: Recycle a lead
    When I click on button with name "recycle"
    Then the field with name "isRecycled" should be visible
    And the status with name "statusSelect" should be "In progress"

  @Failed
  Scenario: Show report of a lead
    When I click on button with xpath "//span[contains(text(), 'Reports')]"
    And I click on button with xpath "//a[@ng-click][contains(text(), 'Print')]"
    Then the report with name "Smith" should be visible
