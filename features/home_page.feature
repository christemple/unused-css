Feature: Home page

  Scenario: Going to a page with a single stylesheet
    Given I go to the home page
    Then I should see style '#heading' was used
    Then I should see style '.sub-heading' was not used


  Scenario: Going to a page with more than one stylesheet
    Given I go to a page with 2 stylesheets
    Then I should see style '#heading' was used
    Then I should see style '.notification' was used
    Then I should see style '.sub-heading' was not used
    Then I should see style '.sub-heading span' was not used
    Then I should see style '.old-error' was not used

