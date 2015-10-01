class SmartPlayer
  def initialize
    @low = 1
    @high = MAX_NUMBER
    @guess = get_middle
  end

  def get_guess(last_result)
    if last_result == :high
      @high = @guess-1
    elsif last_result == :low
      @low = @guess+1
    end
    @guess = get_middle
  end

  private
  def get_middle
    (@low + @high) / 2
  end
end
