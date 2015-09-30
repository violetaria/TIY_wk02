require "pry"

class SmartPlayer
  def initialize
    @low = 1
    @high = MAX_NUMBER
    @guess = get_middle
  end

  def get_middle
    (@low + @high) / 2
  end

  def get_guess(last_result)
    binding.pry
    if last_result == :warmer
      @low = @guess+1
    elsif last_result == :colder
      @high = @guess-1
    end
    @guess = get_middle
    puts "low=#{@low} high=#{@high} and #{@guess} is the new guess."
    @guess
  end
end

#binding.pry
