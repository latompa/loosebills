Feature: cash withdrawal

  Background:
    Given I have set up a user
    And I am logged in

  Scenario: sufficient funds
    Given I have a positive balance
    And I am on the home page
    When I follow an amount choice
    Then I should see the cash
    And my account should be debited
  
  Scenario: not enough funds
    Given I have a zero balance
    And I am on the home page
    Then I should not see any clickable withdrawal choices
