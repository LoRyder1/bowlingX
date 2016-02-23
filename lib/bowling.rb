class BowlingGame
  def initialize
    @total = 0
    @rolls = []  
  end

  def roll pins
    @rolls.push(pins)
  end

  def score
    @total = @rolls.reduce(:+)
    @total
  end
end