Feature: User Signon

  Background:
    Given I have set up a user
    And I am on the home page

  Scenario: User signs on with valid PIN
    When I fill in login with correct details
    Then I should see a welcome user message
  
  Scenario: User signs on with invalid PIN
    When I fill in login with incorrect details
    Then I should see a login incorrect message
  