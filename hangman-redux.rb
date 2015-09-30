require "pry"
require "set"

WORD_LIST = [ "cat", "chick", "duck", "cat", "clown", "brick", "bananas",
              "coffee", "totalitarianism", "metacircular", "interpreter",
              "wednesday", "ruby", "evaluation", "consternation", "chicanery"]

MAX_TURNS = 6


class Game
  def initialize(player1,player2)
    @answer = WORD_LIST.sample
    @player1 = player1
    @player2 = player2
    greeting(player1.name,player2.name)
  end

  def greeting(player1, player2)
    puts "--------------------------"
    puts "Welcome to Hangman!"
    puts "#{player1} and #{player2}, are you ready for a head to head game?"
    puts "Time to start guessing."
    puts"--------------------------\n"
  end

  def win?(current_player)
    answer_set = @answer.chars.to_set
    current_player.guesses >= answer_set
  end

  def game_over?(current_player)
    win?(current_player) || turns_left(current_player).zero? # turn_count==0
  end

  def switch_turn(current_player)
    current_player == @player1 ? @player2 : @player1
  end

  def turns_left(current_player)
    answer_set = @answer.chars.to_set
    wrong_guesses = (current_player.guesses - answer_set).count
    MAX_TURNS - wrong_guesses
  end


  def postmortem(current_player)
    puts win?(current_player) ?  "Slowclap - Congrats #{current_player.name}, YOU WON!" : "#{current_player}, you LOSE which kinda sucks! Better luck next time."
    puts "The word was: #{@answer}."
    puts
  end

  def get_letter
    puts
    print "Please guess a letter: "
    gets.chomp.downcase
  end

  def valid_guess?(letter)
    valid_letters = ("a".."z").to_a
    if(!valid_letters.include?(letter))
      puts "The guess is not a single letter between a and z!  Try again."
      false
    else
      true
    end
  end

  def prompt_player
    guess = get_letter
    until valid_guess?(guess)
      guess = get_letter
    end
    guess
  end

  def show_progress(partial,current_player)
    turns_remaining = turns_left(current_player)
    puts "==> #{current_player.name}, it's your turn. You have #{turns_remaining} guesses left."
    puts "The current word is: #{partial}."
  end

  def make_partial(guesses)
    answer_set = @answer.chars.to_set
    missing = (answer_set - guesses).to_a.join
    @answer.gsub(/[#{missing}]/, "_")
  end

  def take_turn(current_player)
    partial = make_partial(current_player.guesses)
    show_progress(partial,current_player)
    prompt_player
  end

  def play
    current_player = @player1
    until game_over?(current_player)
      guess = take_turn(current_player).downcase # accounting for upper vs. lowercase, all of our pre-set words are lowercase
      current_player.add_guess(guess)
      if(!@answer.include?(guess))
        current_player = switch_turn(current_player)
      end
    end
    postmortem(current_player)

  end
end

class Human
  def initialize(player_name)
    @name = player_name
    @guesses = Set.new
  end

  def name
    @name
  end

  def guesses
    @guesses
  end

  def add_guess(guess)
    @guesses.add(guess)
  end
end

def get_name(player)
  print "Player #{player}, please enter your name: "
  gets.chomp
end

def play_again?
  puts "Play again? (y or n)"
  replay = gets.chomp.downcase
  until replay == "y" || replay == "n"
    puts "\nPlease enter y or n"
    puts "Play again? (y or n)"
    replay = gets.chop.downcase
  end
  replay == "y"
end

def play_hangman
  game = Game.new(Human.new(get_name(1)),Human.new(get_name(2)))
  game.play
  while play_again?
    game = Game.new(Human.new(get_name(1)),Human.new(get_name(2)))
    game.play
  end
end

play_hangman

#play_hangman(word_list)