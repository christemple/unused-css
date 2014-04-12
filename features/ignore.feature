Feature: A user will have some styles ignored by default

  Scenario Outline: Stylesheet contains css at rules
    Given I go to the home page
    Then css rule '<css rule>' should be ignored
  Examples:
    | css rule  |
    | font-face |
    | media     |
    | import    |
    | charset   |


