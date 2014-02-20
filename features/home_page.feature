Feature: Home page

  Scenario: Going to the home page
    Given I go to the home page
    Then I should see style '#heading' was used
    Then I should see style '.sub-heading' was not used