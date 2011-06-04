Feature: Bill Inventory

  Background:
    Given I have set up a user
    And I am logged in
    And I have a positive balance
    
  Scenario: No available bills
    Given the ATM machine has no bills
    And I am on the home page
    Then I should see "Cash can't be dispensed at this time"
    
  Scenario: Available bills
    Given the ATM machine has bills
    And I am on the home page
    Then I should not see "Cash can't be dispensed at this time"