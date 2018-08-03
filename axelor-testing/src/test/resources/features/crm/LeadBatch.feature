@LeadBatch
Feature: Lead batches
  Test processes related to batches on grid of leads

  Scenario: Assign button in lead list
    When I select "CRM" from sidebar
    And I click on "Leads" menu item
    And I click on button with name "Grid"
    And I click on button with name "grabLead" in line with the "Last name" "SMITH"
    Then The field "Assigned to" should be "Admin" in line with the "Last name" "SMITH"

  Scenario Outline: Assign button in lead list
    When I select "CRM" from sidebar
    And I click on "Leads" menu item
    And I wait for data loading
    And I select line with "Last name" <lastName>
    And I click on button with name "Assign to me"
    Then The field statusSelect should be <statusSelect>
    And The field "Assigned to" should be <assignedTo>

    Examples: 
      #The last two columns are just indicatives
      | lastName  | assignedTo   | statusSelect | assignedToBefore | statusSelectBefore |
      | Smith     | Admin        | In progress  | Admin            | Assigned           |
      | Smoth     | Daniel SILVA | In progress  | Admin            | Assigned           |
      | GRIEZMANN | Daniel SILVA | In progress  | Daniel SILVA     | In progress        |

  Scenario: Schedule event through lead list
    When I select "CRM" from sidebar
    And I click on "Leads" menu item
    And I wait for data loading
    And I select line with "Last name" "SMITH"
    And I click on button with name "Schedule event"
    And I wait for data loading
    Then The field "Lead" should be "John SMITH"

  Scenario: Send email through lead list
    When I select "CRM" from sidebar
    And I click on "Leads" menu item
    And I wait for data loading
    And I select line with "Last name" "SMITH"
    And I click on button with name "Send email"
    And I wait for data loading
    Then The field "To" should be "whatever@axelor.com"

  Scenario: Check duplicate

  #TODO
  Scenario: Import leads
    #TODO
