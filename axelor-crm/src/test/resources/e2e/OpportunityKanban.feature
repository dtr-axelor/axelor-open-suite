@Opportunity
Feature: Opportunity kanban
  Test processes related to kanban view of opportunity object

   Background: Open kanban view of opportunities
    When I select "CRM" from sidebar
    And I click on "Opportunities" menu item
    And I wait for data loading

  Scenario: Drag an opportunity from new to qualification status
    When I drag the card with name "A great opportunity" to the "first" line of column with name "Qualification"
    Then The field "statusSelect" should be "Qualification"
    #TODO: check priority auto-assignation
    And The field "orderByState" should be "???"

  Scenario: Drag an opportunity from new to negociation status
    When I drag the card with name "A great opportunity" to the "second" line of column with name "Negociation"
    Then The field "statusSelect" should be "Negociation"
    #TODO: check priority auto-assignation
    And The field "orderByState" should be "???"