Feature: Send out newsletter
  Scenario: Site admin sends out newsletter
    Given I am logged in as 'site admin'
    And I have a 'newsletter' with 'subscribers'
    When I open 'newsletter' and click 'Issue'
    Then 'subscribers' should receive 'newsletter'

  Scenario: Site admin sends out test newsletter
    Given I am logged in as 'site admin'
    And I have a 'newsletter' with 'subscribers'
    When I open 'newsletter' and click 'Test Issue'
    Then only I receive 'newsletter'

  Scenario: Site admin sends out newsletter with 2 hours delay
    Given I am logged in as 'site admin'
    And I have a 'newsletter' with 'subscribers'
    When I open 'newsletter' and select '2 hours' delay
    Then I should see 'newsletter' in the 'newsletter queue'
    And 'subscribers' should receive 'newsletter' with '2 hours' delay
    
  Scenario: Site admin cancels delayed newsletter
    Given I am logged in as 'site admin'
    And I have delayed 'newsletter' in the 'newsletter queue'
    When I click 'cancel issue' at the 'newsletter page'
    Then 'newsletter' issue should be cancelled
    And I should not see 'newsletter' at the 'newsletter queue'
