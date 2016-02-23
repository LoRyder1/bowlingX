describe 'Bowling Game' do
  subject { BowlingGame.new }

  def roll_many rolls, pins
    rolls.times {subject.roll(pins)}
  end

  it 'a gutter game results in a zero' do
    roll_many 20, 0
    expect(@game.score).to eq 0
  end
end
