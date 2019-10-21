Feature:
  As a network tattler
  I can inquire knowledge
  So I can catch up with the news

  Background:
    Given there is a network tattler "A"
    And there is a network tattler "B"

  Scenario: I inquire information
    Given "A" is remotely connected to "B"
    And "B" knew about "Bitcoin"
    When "A" inquires "B"
    Then "A" knows about "Bitcoin"
