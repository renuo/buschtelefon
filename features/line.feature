Feature:
  As a tattler
  I can listen to other tattlers' gossip
  So I can use and share it to others

  Background:
    Given there is a tattler "A"
    And there is a tattler "B"
    And there is a tattler "C"

  Scenario: Gossip is received by connected neighbor
    Given "A" is connected to "B"
    When "A" gossips about "Bitcoin"
    Then "B" knows about "Bitcoin"

  Scenario: Gossip is being handed over a middleman
    Given "A" is connected to "B"
    Given "B" is connected to "C"
    When "A" gossips about "Bitcoin"
    Then "C" knows about "Bitcoin"

  Scenario: Gossing doesn't propagate back to unconnected party
    Given "A" is connected to "B"
    Given "B" is connected to "C"
    When "B" gossips about "Bitcoin"
    Then "A" doesn't know about "Bitcoin"
