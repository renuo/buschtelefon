Feature:
  As a tattler
  I can talk freely
  Even if I am not connected to others

  Background:
    Given there is a tattler "A"
    And there is a tattler "B"
    And there is a tattler "C"

  Scenario: Nobody hears A
    When "A" gossips about "Bitcoin"
    Then "B" doesn't know about "Bitcoin"
    Then "C" doesn't know about "Bitcoin"
