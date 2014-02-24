Feature: As a human I would like to see some sort of report of the unused css

  Scenario: Unused styles are printed in a html file
    Given I open the report html file
    Then I should see '/stylesheets/style.css'
    And I should not see '#heading'
    And I should see '.sub-heading'
    And I should see '.sub-heading span'
    And I should see '/stylesheets/multiple.css'
    And I should not see '.notification'
    And I should see '.old-error'
