require "pry"
require "./human"
require "./random"
require "./counting"
require "./smart_hard"

MAX_NUMBER = 100

class GuessingGame
  def initialize(player)
    @player = player
  end

  def play
    number = rand(1..MAX_NUMBER)
    result = nil  # setup result variable
    guess = @player.get_guess(result)
    count = 0
    temp = get_temp(guess,number)
    until guess == number
      guess = @player.get_guess(result)
      last_temp = temp
      temp = get_temp(guess,number)
      if temp < last_temp
        result = :warmer
        puts "Warmer!"
      else
        result = :colder
        puts "Colder!"
      end
      count += 1
      puts "number = #{number}, guess=#{guess} and last=#{last_temp} and temp=#{temp}"
#      binding.pry
    end
    puts "You win! Took #{count} tries. The number was #{number}."
  end

  def get_temp(guess,number)
    (number - guess).abs
  end
end

game = GuessingGame.new(SmartPlayer.new)

game.play

puts "just screwing around"