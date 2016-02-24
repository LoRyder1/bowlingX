def roll_many rolls, pins
  rolls.times { @game.roll(pins) }
end

Given(/^I have created a new bowling game$/) do
  @game = BowlingGame.new
end

When(/^I roll a gutter game$/) do
  roll_many(20,0)
end

Then(/^my score should be (\d+)$/) do |number|
  expect(@game.score).to eq number
end

When(/^I roll a game of one spare with a bonus (\d+)$/) do |bonus|
  @game.roll(5)
  @game.roll(5)
  @game.roll(bonus)
  roll_many(17,0)
end
