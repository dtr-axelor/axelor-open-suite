@Opportunity
Feature: Opportunity
  Test processes related to opportunity object

  Scenario: Navigate to opportunity list
    When I select "CRM" from sidebar
    And I click on "Opportunities" menu item
    Then I wait for data loading
    And I should see tab "Opportunities"

  Scenario Outline: Create an opportunity from a lead
    When I select "CRM" from sidebar
    And I click on "Leads" menu item
    And I wait for data loading
    And I click on button with name "Grid"
    And I open lead with Last name <last name>
    And I click on button with name "Tools"
    And I click on button with name "Create opportunity"
    Then The field "Assigned to" should be <assigned to>
    And The field "Status" should be "New"
    And The field "Lead" should be <lead>
    And The field "Customer" should be <partner>
    # And The field "Contact" should be <contact>
    Examples:
      | last name | assigned to  |    lead    | partner |  contact   |       email         |
      |   Smith   |    Admin     | John SMITH | Apollo  | John SMITH |                     |
      |   Smoth   | Daniel SILVA | Jihn SMOTH | Luxuria | Jihn SMOTH | j.smith@luxuria.com |

  Scenario: Qualify an opportunity
    When I type "A great opportunity" in field with name "Name"
    And I click on button with name "Next step"
    Then The field "Status" should be "Qualification"

  Scenario: Create quotation from a lead
    When I click on button with name "Tools"
    And I click on button with name "Convert into quotation"
    And I click on button with name "OK"
    And I wait for data loading
    Then The field "Customer" should be "John SMITH"
    And The field "Opportunity" should be "A great opportunity"

  Scenario: Check update of opportunity
    When I click on tab "Opportunity"
    And I click on panel "Sale quotations/orders"
    Then I should see in panel "Sale quotations/orders" 1 element
    And The field "Status" should be "Proposition"

  Scenario: Propose an opportunity
    When I click on button with name "Previous step"
    And I click on button with name "Next step"
    Then The field "Status" should be "Proposition"

  Scenario: Negotiate an opportunity
    When I click on button with name "Next step"
    Then The field "Status" should be "Negotiation"

  Scenario: Lose an opportunity
    When I click on button with name "Lose"
    And I type "Project cancelled" in field with name "Lost reason"
    And I click on button with name "OK"
    Then The field "Status" should be "Closed won"
    And The field "Lost reason" should be "Project cancelled"

  Scenario: Win an opportunity
    When I click on button with name "Previous step"
    And I click on button with name "Win"
    Then The field "Status" should be "Closed won"

  Scenario: Check update of lead
    When I click on tab "Lead"
    And I click on panel "Activities"
    And I right click on tab "Lead"
    And I click on button with name "Refresh"
    Then I should see in panel "Opportunities" 1 event(s)

    #TODO: check email sending ???
  # Where is email option in opportunity ?
