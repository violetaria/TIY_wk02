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
    guess = @player.get_guess_new(result)
    count = 0
    last_temp = 0
    until guess == number
      temp = get_temp(guess,number)
      if temp < last_temp
        result = :warmer
        puts "Warmer!"
      else
        result = :colder
        puts "Colder!"
      end
      guess = @player.get_guess_new(result)
      last_temp = temp
      count += 1
      binding.pry
    # guess - number - guess to determine if it's warmer or colder
    end
  end

  def get_temp(guess,number)
    (number - guess).abs
  end

game = GuessingGame.new(SmartPlayer.new)

game.play

binding.pry

puts "just screwing around"