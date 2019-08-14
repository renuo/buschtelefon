Feature:
  As a tattler
  I can talk to myself
  So I don't feel so lonely

  Background:
    Given there is a tattler "A"
    And "A" doesn't know about "Bitcoin"

  Scenario: Nobody listening
    When "A" gossips about "Bitcoin"
    Then "A" knows about "Bitcoin"

  Scenario: Shizo
    Given "A" is connected to "A"
    When "A" gossips about "Bitcoin"
    And "A" knows about "Bitcoin"
