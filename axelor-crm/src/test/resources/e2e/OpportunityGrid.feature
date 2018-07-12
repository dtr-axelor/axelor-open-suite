@Opportunity
Feature: Opportunity grid
  Test processes related to grid view of opportunity object

   Background: Open grid view of opportunities
    When I select "CRM" from sidebar
    And I click on "Opportunities" menu item
    And I wait for data loading
    And I click on button with name "Grid"
    And I select the line with the "Name" "A great opportunity"

  Scenario: Assign button in opportunity list
    When I click on button with icon "fa-suitcase"
    Then The field "Assigned to" should be "Admin"

  Scenario: Next step button (qualification) in opportunity list
    When I click on button with icon "fa-chevron-circle-right"
    Then The field "statusSelect" should be "Qualification"

  Scenario: Next step button (proposition) in opportunity list
    When I click on button with icon "fa-chevron-circle-right"
    Then The field "statusSelect" should be "Proposition"

  Scenario: Next step button (negociation) in opportunity list
    When I click on button with icon "fa-chevron-circle-right"
    Then The field "statusSelect" should be "Negociation"

  Scenario: Win button in opportunity list
    When I click on button with icon "fa-check-circle"
    Then The field "statusSelect" should be "Closed won"
    And The selected line should be "green"

  Scenario: Lose button in opportunity list
    When I select the line with the "Name" set at "Another great opportunity"
    And I click on button with icon "fa-minus-circle"
    Then The field "statusSelect" should be "Closed lost"
    And The selected line should be "red"
