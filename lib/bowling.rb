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
    while roll_valid?
      set_rolls
      score_frame
    end
    return @total
  end

  private
  def roll_valid?
    @current_roll < @rolls.length - 1
  end

  def set_rolls
    @roll = @rolls[@current_roll]
    @next_roll = @rolls[@current_roll + 1]
    @roll_after_next = @rolls[@current_roll + 2]
  end

  def score_frame
    if strike?
      score_strike
    elsif spare?
      score_spare
    else
      normal_score
    end
  end

  def strike?
    @roll == 10
  end

  def spare?
    @roll + @next_roll == 10
  end

  def score_strike
    @total += 10 + @next_roll + @roll_after_next
    @current_roll += 1
  end

  def score_spare
    @total += 10 + @roll_after_next
    @current_roll += 2
  end

  def normal_score
    @total += @roll + @next_roll
    @current_roll += 2 
  end
end
