describe 'Bowling Game' do
  subject { BowlingGame.new }

  def roll_many rolls, pins
    rolls.times {subject.roll(pins)}
  end

  def score_spare
    subject.roll 5
    subject.roll 5
  end

  def score_strike
    subject.roll 10
  end

  describe '#roll' do

    it 'is a method defined in Bowling Game' do
      expect(BowlingGame.method_defined?(:roll)).to eq true
    end

    it 'takes one argument' do
      expect(subject.method(:roll).arity).to eq 1
    end
  end

  describe 'complete games' do

    it 'a gutter game results in zero' do
      roll_many 20,0
      expect(subject.score).to eq 0
    end

    it 'a game of all ones' do
      roll_many 20,1
      expect(subject.score).to eq 20
    end

    it 'a game with one spare' do
      score_spare
      subject.roll 4
      roll_many 17,0
      expect(subject.score).to eq 18
    end

    it 'a game with one strike' do
      score_strike
      subject.roll 4
      subject.roll 4
      roll_many 17,0
      expect(subject.score).to eq 26
    end
  end
 end
