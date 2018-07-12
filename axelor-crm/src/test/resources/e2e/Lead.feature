@Lead
Feature: Lead
  Test processes related to lead object

  Scenario: Navigate to lead list
    When I select "CRM" from sidebar
    And I click on "Leads" menu item
    Then I wait for data loading

  Scenario: Create a lead
    When I click on "New" button
    Then The field "statusSelect" should be "New"

  Scenario: Start a lead without filling a name
    When The field "Name" is empty
    And I click on "Start" button
    And I wait for data loading
    Then The field "statusSelect" should be "New"
    And I should see a notification "The following fields are invalid: Last name"

  Scenario: Assign a lead to someone else
    When I type "Smith" in field with name "Name"
    And I type "whatever@axelor.com" in field with name "Email"
    And I select "Daniel SILVA" from field with name "Assigned to"
    And I click on "Save" button
    Then I wait for data loading
    And The field "statusSelect" should be "Assigned"

  Scenario: Assign a lead to me
    When I click on "Assign to me" button
    Then I wait for data loading
    And The field "statusSelect" should be "Assigned"
    And The field "Assigned to" should be "Admin"

  Scenario: Start a lead
    When I click on "Start" button
    Then The field "statusSelect" should be "In progress"

  Scenario: Lose a lead
    When I click on "Lose" button
    And I select "Project cancelled" from field with name "Lost reason"
    And I click on "Confirm lost reason" button
    Then The field "statusSelect" should be "Lost"
    And The field "Lost reason" should be "Project cancelled"

  Scenario: Recycle a lead
    When I click on "Recycle" button
    Then The field "statusSelect" should be "In progress"
    And I should see the flag "Recycled"

  Scenario: Start a lead which is an individual and not an existing partner or contact
    When I click on "Start" button
    And I select "Individual" from field with name "Partner Type"
    Then The field "Last name" should be "Smith"
    And The field "Prospect" should be "true"

  Scenario: Start a lead which is an individual and not an existing partner or contact
    When I select "Select existing partner" from field with name "Lead to partner"
    And I select "APOLLO" from field with name "Select Partner"
    Then The field "Last name" should be "Smith"

  Scenario: Validate lead conversion
    When I click on "Validate" button
    And I wait for data loading
    And I click on "OK" button
    Then I should see the pop-up "Lead converted"
    And I click on "OK" button
    And I should see the tab "Customer"
    And I should see in Panel "Contacts" a line with "Name" set to "Smith"

  Scenario: Check lead conversion
    When I click on Lead tab
    Then The field "statusSelect" should be "Converted"
    And I should see the button "Show Partner"

  Scenario: Display partner linked with a lead
    When I click on Lead tab
    And I click on button with x-menus "toolmenu"
    And I click on button with name "Refresh"
    And I click on button with name "Show Partner"
    Then I should see in Panel "Contacts" a line with "Name" set to "Smith"

  Scenario: Show report of a lead
    When I click on Lead tab
    And I click on button with name "Reports"
    And I click on button with name "Print"
    Then I should see the report with name "John Smith"


    # --- PROCESSES IN GRID VIEW OF LEADS --- #

  Scenario: Assign button in lead list
    When I select "CRM" from sidebar
    And I click on "Leads" menu item
    And I wait for data loading
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
      | lastName  |  assignedTo  | statusSelect | assignedToBefore | statusSelectBefore |
      |   Smith   |     Admin    | In progress  |      Admin       |      Assigned      |
      |   Smoth   | Daniel SILVA | In progress  |      Admin       |      Assigned      |
      | GRIEZMANN | Daniel SILVA | In progress  |   Daniel SILVA   |    In progress     |

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