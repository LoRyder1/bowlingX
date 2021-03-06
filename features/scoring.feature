Feature: Scoring a Bowling Game
As a player
I want to be able to score a game with 10 frames
I want to keep track of my score in the bowling game

  Scenario: A gutter game should give a score of zero
  Given I have created a new bowling game
  When I roll a gutter game
  Then my score should be 0

  Scenario: A game with one spare
  Given I have created a new bowling game
  When I roll a game of one spare with a bonus 4
  Then my score should be 18

  Scenario: A game with one strike
  Given I have created a new bowling game
  When I roll one strike with bonus 4 and 4
  Then my score should be 26