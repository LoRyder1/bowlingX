class BowlingGame
  def initialize
    @total = 0
    @rolls = []
    @current_roll = 0
  end

  def roll pins
    @rolls.push(pins)
  end

  def score
    while @current_roll < @rolls.length - 1
      set_rolls

      if spare?
        score_spare
      else
        normal_score
      end
    end
    # @total = @rolls.reduce(:+)
    return @total
  end

  def set_rolls
    @roll = @rolls[@current_roll]
    @next_roll = @rolls[@current_roll +1]
  end

  def spare?
    false
  end

  def score_spare
    
  end

  def normal_score
    @total += @roll + @next_roll
    @current_roll += 2 
  end
end