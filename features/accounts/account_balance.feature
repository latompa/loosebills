Feature: account balance

  Background:
    Given I have set up a user
    And I have a positive balance
    And I am logged in

  Scenario: view account balance
    Given I am on the home page
    Then I should see my balance