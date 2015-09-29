class SmartPlayer
  def initialize
    @guess = 50
    @low = 1
    @high = 100
  end

  def get_guess(last_result)
    if last_result == :high
      @high = @guess-1
      @guess = (@low + @high) / 2
    elsif last_result == :low
      @low = @guess+1
      @guess = (@low + @high) / 2
    else
      @guess
    end
  end

end
