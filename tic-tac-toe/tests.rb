require 'pry'
require 'minitest/autorun'

require './player'
require './human'
require './random'
require './board'
require './game'

class PlayerTest < MiniTest::Test
  def test_can_make_player
    named_player = Player.new("Terri")
    assert_equal(named_player.name, "Terri")

    unnamed_player = Player.new
    assert_equal(unnamed_player.name,"Unimatrix Zero")
  end

  def test_can_set_and_get_token
    player = Player.new
    player.token = "X"
    assert player.token,"X"
  end
end

class HumanPlayerTest < MiniTest::Test
  def test_can_make_human_player
    @named_human_player = HumanPlayer.new("Terri")
    assert_equal(@named_human_player.name,"Terri")
  end
end


class RandomPlayerTest < MiniTest::Test
  def setup
    @player = RandomPlayer.new
  end

  def test_can_make_random_player
    assert_equal(@player.name,"Unimatrix Zero")
  end
end

class BoardTest < MiniTest::Test
  def setup
    @valid_moves = (1..9).to_a
  end
  def test_can_make_board
    board = Board.new
    assert board
  end

  def test_can_display_board
    board = Board.new
    assert_output(/^[|\s1-9]+$/) { board.display }
  end

  def test_can_update_board
    board = Board.new
    @valid_moves.each do |spot|
      board.update!(spot,"X")
      assert_equal board.get_value(spot),"X"
    end
  end

  def test_can_detect_win?
    board = Board.new
    refute board.win?
    WINNING_BOARDS.each do |x,y,z|
      board.update!(x+1,"X")
      board.update!(y+1,"X")
      board.update!(z+1,"X")
      assert board.win?
      board.update!(x+1,x+1)
      board.update!(y+1,y+1)
      board.update!(z+1,z+1)
    end
  end

  def test_can_detect_draw?
    board = Board.new
    refute board.draw?
    # win board = [ X X X
    #               4 5 6
    #               7 8 9]
    board.update!(1,"X")
    board.update!(2,"X")
    board.update!(3,"X")
    refute board.draw?

    # draw board = [ X", "X", "O", "O", "X", "X", "X", "O", "O"]
    board.update!(1,"X")
    board.update!(2,"X")
    board.update!(3,"O")
    board.update!(4,"O")
    board.update!(5,"X")
    board.update!(6,"X")
    board.update!(7,"X")
    board.update!(8,"O")
    board.update!(9,"O")

    assert board.draw?
  end

  def test_is_move_valid?
    board = Board.new
    move = @valid_moves.sample
    assert board.valid_move?(move)

    board.update!(move,"X")

    refute board.valid_move?(move)

    refute board.valid_move?(".")

    refute board.valid_move?("bull terrier")
  end
end

class GameTest < MiniTest::Test
  def test_can_make_game
    game = Game.new(HumanPlayer.new("Terri"),HumanPlayer.new("Yang"),Board.new)
    assert game
  end

  def test_can_determine_game_over?
    board = Board.new

    game = Game.new(HumanPlayer.new("Terri"),HumanPlayer.new("Yang"),board)

    refute game.game_over?

    WINNING_BOARDS.each do |x,y,z|
      board.update!(x+1,"X")
      board.update!(y+1,"X")
      board.update!(z+1,"X")
      assert game.game_over?
      board.update!(x+1,x+1)
      board.update!(y+1,y+1)
      board.update!(z+1,z+1)
    end
    refute game.game_over?

    ## test for draw
    board.update!(1,"X")
    board.update!(2,"X")
    board.update!(3,"O")
    board.update!(4,"O")
    board.update!(5,"X")
    board.update!(6,"X")
    board.update!(7,"X")
    board.update!(8,"O")
    board.update!(9,"O")

  #  binding.pry
    assert game.game_over?
  end

  def test_can_player_take_turn
    game = Game.new(RandomPlayer.new,RandomPlayer.new,Board.new)
    first_player = game.current_player
    game.take_turn
    refute_equal first_player,game.current_player
    # do we need to check for open spots?
  end

  def test_can_play_game
    game = Game.new(RandomPlayer.new,RandomPlayer.new,Board.new)
    refute game.game_over?

    game.play
    assert game.game_over?
  end

  def test_can_reset_game

  end
end
