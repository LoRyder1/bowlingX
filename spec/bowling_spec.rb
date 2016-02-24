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

  def get_var var
    subject.instance_variable_get(var.to_sym)
  end

  def set_var var, value
    subject.instance_variable_set(var.to_sym, value)
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
      set_var "@current_roll", 1; set_var "@rolls", Array.new(20, 0)
      expect(subject.send(:roll_valid?)).to eq true
    end

    it 'roll is invalid if more than total rolls' do
      set_var "@current_roll", 20; set_var "@rolls", Array.new(20, 0)
      expect(subject.send(:roll_valid?)).to eq false
    end
  end

  describe '#set_rolls' do

    it 'sets roll being used now' do
      set_var "@current_roll", 1; set_var "@rolls", [7,8,9,11]
      subject.send(:set_rolls)
      expect(get_var("@roll")).to eq 8
    end

    it 'sets next_roll being used' do
      set_var "@current_roll", 1; set_var "@rolls", [7,8,9,11]
      subject.send(:set_rolls)
      expect(get_var("@next_roll")).to eq 9
    end

    it 'sets roll_after_next being used' do
      set_var "@current_roll", 1; set_var "@rolls", [7,8,9,11]
      subject.send(:set_rolls)
      expect(get_var("@roll_after_next")).to eq 11
    end
  end

  describe '#strike?' do

    it 'if roll is 10 = true' do
      set_var "@roll", 10
      expect(subject.send(:strike?)).to eq true
    end

    it 'if roll is not 10 = false' do
      set_var "@roll", 9
      expect(subject.send(:strike?)).to eq false
    end
  end

  describe '#spare?' do

    it 'if current and next roll is 10 = true' do
      set_var "@roll", 5; set_var "@next_roll", 5
      expect(subject.send(:spare?)).to eq true
    end

    it 'if current and next roll is not 10 = false' do
      set_var "@roll", 5; set_var "@next_roll", 4
      expect(subject.send(:spare?)).to eq false
    end
  end

  describe '#score_strike' do

    it 'properly score strike' do
      set_var "@roll_after_next", 9; set_var "@next_roll", 8
      subject.send(:score_strike)
      expect(get_var "@total").to eq 27
    end

    it 'current roll is incremented by 1' do
      set_var "@roll_after_next", 9; set_var "@next_roll", 8      
      subject.send(:score_strike)
      expect(get_var "@current_roll").to eq 1
    end

    it 'if roll_after_next is nil end of game' do
      subject.send(:score_strike)
      expect(get_var "@current_roll").to eq 2
    end
  end

  describe '#score_spare' do

    it 'properly score spare' do
      set_var "@roll_after_next", 4; subject.send(:score_spare)
      expect(get_var "@total").to eq 14
    end

    it 'current roll is incremented by 2' do
      set_var "@roll_after_next", 4; subject.send(:score_spare)
      expect(get_var "@current_roll").to eq 2
    end
  end

  describe '#normal_score' do

    it 'properly score a normal frame' do
      set_var "@roll", 3; set_var "@next_roll", 5
      subject.send(:normal_score)
      expect(get_var "@total").to eq 8
    end

    it 'current roll is incremented by 2' do
      set_var "@roll", 2; set_var "@next_roll", 3
      subject.send(:normal_score)
      expect(get_var "@current_roll").to eq 2
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

    it 'a perfect game of 4 strikes' do
      roll_many 4,10
      expect(subject.score).to eq 60
    end

    it 'a perfect game of 20 strikes' do
      roll_many 12,10
      expect(subject.score).to eq 300
    end
  end
end
