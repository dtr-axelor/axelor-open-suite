@Event
Feature: Event
  Test processes related to event object

  Scenario: Create an email from a lead
    When I select "CRM" from sidebar
    And I click on "Leads" menu item
    And I wait for data loading
    And I open lead with Last name "Smith"
    And I click on button with name "Tools"
    And I click on button with name "Send email"
    And I wait for tab "Email" to open
    Then The field "To" should be "whatever@axelor.com"

  Scenario: Send an email
    #TODO
    When I select "???" in field with name "Mail account"
    And I type "Subject - lead test" in field with name "Subject"
    And I click on button with name "Send"
    Then
    #TODO