require "pry"
require "./human"
require "./random"
require "./counting"
require "./smart"

MAX_NUMBER = 100

class GuessingGame
  def initialize(player)
    @player = player
  end

  def play
    number = rand(1..MAX_NUMBER)
    result = nil # setup result variable
    guess = @player.get_guess(result)
    count = 1
    until guess == number
      if guess > number
        result = :high
        puts "Too High!"
      else
        result = :low
        puts "Too Low!"
      end
      guess = @player.get_guess(result)
      count += 1
    end
    puts "You win! Took #{count} tries. The number was #{number}."
  end
end

game = GuessingGame.new(SmartPlayer.new)

game.play

puts "just screwing around"