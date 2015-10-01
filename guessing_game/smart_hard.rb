class SmartPlayer
  def initialize
    @guess = 50
    @offset = 50
    @direction = 1
  end

  def get_guess(last_result)
    if last_result == :colder
      #@offset *= 2 unless @offset==1
      @direction = -@direction
    else #warmer
      @offset /= 2 unless @offset==1
    end
    binding.pry
    puts "offset = #{@offset}"
    @guess < 0 ? 1 : (@guess + (@direction * @offset))
  end

end
