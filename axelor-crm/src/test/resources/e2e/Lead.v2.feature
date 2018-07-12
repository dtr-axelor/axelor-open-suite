@Lead
Feature: Lead
  Test processes related to lead object

  Scenario: Navigate to Lead list
    When I click on menu with data-name "crm-root"
    And I click on menu with data-name "crm-root-lead"
    Then I wait for data loading

  Scenario: Create a lead
    When I click on "New" button
    And The field "Name" is not filled
    Then The field "statusSelect" should be "New"
    And I should see a notification "The following fields are invalid"

  Scenario: Start a lead without filling a name
    When I click on "Start" button
    And The field "Name" is not filled
    Then The field "statusSelect" should be "New"
    And I should see a notification "The following fields are invalid"

  Scenario: Assign a lead
    When The field "Name" is filled
    And The field "Assigned to" is not filled
    When I click on "Assign to me" button
    Then The field "statusSelect" should be "Assigned"

  Scenario: Start a lead
    When I fill the field "Name" with "Smith"
    And I click on "Start" button
    Then The field "statusSelect" should be "In progress"
    And The field "Assigned to" should be "Admin"

  Scenario: Convert a lead
    Given I navigate to URL "https://test.axelor.com/abs-wip/#/ds/crm.root.lead/edit/12"
    When I click on "Convert" button
    Then The field "statusSelect" should be "In progress"
    And The field "Assigned to" should be "Admin"