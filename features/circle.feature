Feature:
  As a tattler
  I can share gossip in a circle setup
  Without fearing a collapse

  Background:
    Given there is a tattler "A"
    And there is a tattler "B"
    And there is a tattler "C"

  Scenario: A gossip is propagated through a circle of two
    Given "A" is connected to "B"
    And "B" is connected to "A"
    When "B" gossips about "Bitcoin"
    Then "A" knows about "Bitcoin"

  Scenario: A gossip makes it through an unidirectional circle of three
    Given "A" is connected to "B"
    And "B" is connected to "C"
    And "C" is connected to "A"
    When "B" gossips about "Bitcoin"
    Then "C" knows about "Bitcoin"
    Then "A" knows about "Bitcoin"

  Scenario: A gossip makes it through a bidirectional circle of three
    Given "A" is connected to "B"
    And "B" is connected to "A"
    And "B" is connected to "C"
    And "C" is connected to "A"
    And "A" is connected to "C"
    When "B" gossips about "Bitcoin"
    Then "C" knows about "Bitcoin"
    Then "A" knows about "Bitcoin"
