require 'pry'
require './player'
require './human'
require './random'
require './board'
require './game'

print "\nHow many Human players? (0 - 2) "
num_players = gets.chomp.to_i
until ((0..2).include?(num_players))
  puts "Please pick enter 0, 1, or 2!"
  print "\nHow many players? (0 - 2) "
  num_players = gets.chomp.to_i
end

case num_players
  when 0
    game = Game.new(RandomPlayer.new,RandomPlayer.new,Board.new)
  when 1
    game = Game.new(HumanPlayer.new,RandomPlayer.new,Board.new)
  when 2
    game = Game.new(HumanPlayer.new,HumanPlayer.new,Board.new)
  else
    puts "there is no way, that you should even be here!!!  check your code!"
end

game.play
replay = nil

until replay == "n"
  puts "Play again? (y or n)"
  replay = gets.chomp.downcase
  #binding.pry
  until replay == "y" || replay == "n"
    puts "\nPlease enter y or n"
    puts "Play again? (y or n)"
    replay = gets.chop.downcase
  end
  if replay == "y"
    game.reset!
    game.play
  end
end