@Event
Feature: Event
  Test processes related to event object

  Scenario: Navigate to event list
    When I select "CRM" from sidebar
    And I click on "Events" menu item
    Then I wait for data loading
    And I should see tab "Events"

  Scenario Outline: Schedule an event from a lead
    When I select "CRM" from sidebar
    And I click on "Leads" menu item
    And I wait for data loading
    And I click on button with name "Grid"
    And I select line with "Last name" <last name>
    And I click on button with name "Form view"
    And I click on button with name "Tools"
    And I click on button with name "Schedule Event"
    Then The field "Assigned to" should be <assigned to>
    # next steps are not working currently in ABS
    And The field "Status" should be "Planned"
    And The field "Lead" should be <lead>
    And The field "Partner" should be <partner>
    And The field "Contact" should be <contact>
    And The field "Email address" should be <email>

    Examples:
      | last name | assigned to  |    lead    | partner |  contact   |       email         |
      |   Smith   |    Admin     | John SMITH | Apollo  | John SMITH |                     |
      |   Smoth   | Daniel SILVA | Jihn SMOTH | Luxuria | Jihn SMOTH | j.smith@luxuria.com |

  Scenario: Create an event from a lead
    When I type "Annual meeting" in field with name "Subject"
    And I type "00100" in field with name "Duration"
    And I press "Enter" key
    And I click on button with name "Tools"
    And I click on button with name "Create event"
    And I click on tab "Lead"
    And I click on panel "Activities"
    And I right click on tab "Lead"
    And I click on button with name "Refresh"
    Then I should see in panel Events 1 event
    And I should see in panel Events 1 email
