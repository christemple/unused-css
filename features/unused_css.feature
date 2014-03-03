Feature: A user should be able to see when styles are unused

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


  Scenario: Going to a page with styles for hover state
    Given I go to a page with 2 stylesheets
    Then I should see style '#heading' was used
    Then I should see style '.notification' was used
    Then I should see style '.notification:hover' was used
    Then I should see style '.sub-heading' was not used
    Then I should see style '.sub-heading span' was not used
    Then I should see style '.old-error' was not used


  Scenario: Going to a page that loads content via AJAX
    Given I go to the home page
    Then I should see style '#heading' was used
    Then I should see style '.sub-heading' was not used
    Then I should see style '#ajaxed-content' was not used
    When I wait for content to be loaded into the DOM via AJAX
    Then I should see 'I was pulled in by AJAX'
    When I recheck the styles on the page
    Then I should see style '#ajaxed-content' was used
