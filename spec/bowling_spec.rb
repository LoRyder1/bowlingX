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

  def set_var var, value
    subject.instance_variable_set(var.to_sym, value)
  end  

  def get_var var
    subject.instance_variable_get(var.to_sym)
  end

  describe '#roll' do

    it 'is a method defined in Bowling Game' do
      expect(BowlingGame.method_defined?(:roll)).to eq true
    end

    it 'takes one argument' do
      expect(subject.method(:roll).arity).to eq 1
    end

    it 'pushs pins into array' do
      subject.roll 2
      expect(get_var("@rolls")).to eq [2]
    end
  end

  describe '#roll_valid?' do

    it 'roll is valid if less than total rolls' do
      set_var "@rolls", Array.new(20, 0)
      expect(subject.roll_valid?).to eq true
    end

    it 'roll is invalid if more than total rolls' do
      set_var "@current_roll", 20
      set_var "@rolls", Array.new(20, 0)
      expect(subject.roll_valid?).to eq false
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
