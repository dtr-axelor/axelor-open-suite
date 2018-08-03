@Test @Lead
Feature: Lead
  Test processes related to lead object

  @Passed
  Scenario: Create a lead
    When I click on menu with name "crm-root" and wait for 1 second
    And I click on menu with name "crm-root-lead" and wait for 1 second
    And I click on button with selector "div.navbar.record-toolbar > div > div > div.btn-group > [title='New']" and wait for 1 second
    Then the status with name "statusSelect" should be "New"

  @Passed
  Scenario: Start a lead without filling a name
    When I type "" in textbox with name "name" and wait
    And I click on button with name "start" and wait for 1 second
    Then the status with name "statusSelect" should be "New"
    And a notification with text "The following fields are invalid: Last name" should appear

  @Passed
  Scenario: Assign a lead to someone else
    When I type "Smith" in textbox with name "name" and wait
    And I type "whatever@axelor.com" in textbox with name "address" and wait
    And I select "Daniel SILVA" from field with name "user" and wait
    And I click on button with selector "div.navbar.record-toolbar > div > div > div.btn-group > [title='Save']" and wait for 3 seconds
    Then the status with name "statusSelect" should be "Assigned"

  @Passed
  Scenario: Assign a lead to me
    When I click on button with name "grabLead" and wait for 2 seconds
    Then the status with name "statusSelect" should be "Assigned"
    And the field with name "user" should have value "Admin"

  @Failed
  Scenario: Start a lead
    When I click on button with name "start" and wait for 2 second
    Then the status with name "statusSelect" should be "In progress"

  @Failed
  Scenario: Lose a lead
    When I click on button with name "lose" and wait for 2 second
    #This assumes that the lost reason has been added through CRM config menu
    And I select "Project cancelled" from field with selector "[name='lostReason'] > span > input" and wait for 1 second
    And I click on button with name "lostReasonConfirm" and wait for 4 seconds
    Then the status with name "statusSelect" should be "Lost"
    And the field with selector "[name='lostReason'] > span > a" should have value "Project cancelled"

  @Failed
  Scenario: Recycle a lead
    When I click on button with name "recycle" and wait for 1 second
    Then the field with name "isRecycled" should be visible
    And the status with name "statusSelect" should be "In progress"
