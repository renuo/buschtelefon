Feature:
  As a tattler
  I can listen to other tattlers' gossip
  So I can use and share it

  Background:
    Given there's tattler "A"
    And there's tattler "B"

  Scenario: Tattler A listens to tattler B
    Given "A" is connected to "B"
    When "B" gossips about "Bitcoin"
    Then "A" hears "Bitcoin"
