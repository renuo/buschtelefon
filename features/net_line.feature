Feature:
  As a network tattler
  I can receive messages
  So I can use and share them

  Background:
    Given there is a network tattler "A"
    And there is a network tattler "B"
    And there is a network tattler "C"

  Scenario: I send a message to a remote tattler
    Given "A" is remotely connected to "B"
    When "A" gossips about "Bitcoin"
    Then "B" knows about "Bitcoin"

  Scenario: I can send a message to a remote tattler via another one
    Given "A" is remotely connected to "B"
    And "B" is remotely connected to "C"
    When "A" gossips about "Bitcoin"
    Then "C" knows about "Bitcoin"
