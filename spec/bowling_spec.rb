describe 'Bowling Game' do
  subject { BowlingGame.new }

  def roll_many rolls, pins
    rolls.times {subject.roll(pins)}
  end

  describe '#roll' do

    it 'is a method defined in Bowling Game' do
      expect(BowlingGame.method_defined?(:roll)).to eq true
    end

    it 'takes one argument' do
      expect(subject.method(:roll).arity).to eq 1
    end
  end


  it 'a gutter game results in zero' do
    roll_many 20,0
    expect(subject.score).to eq 0
  end
 end
