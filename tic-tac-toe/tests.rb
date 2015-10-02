require 'pry'
require 'minitest/autorun'

require './player'
require './human'
require './random'
require './board'

class PlayerTest < MiniTest::Test
  def test_can_make_player
    named_player = Player.new("Terri")
    assert_equal(named_player.name, "Terri")

    unnamed_player = Player.new
    assert_equal(unnamed_player.name,"Unimatrix Zero")
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
    #@computer = RandomPlayer.new
    #@human = HumanPlayer.new("Terri")
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
      board.update!(spot-1,"X")
      assert_equal board.get_value(spot-1),"X"
    end
  end

  def test_can_user_win?
    board = Board.new
    refute board.win?
    WINNING_BOARDS.each do |x,y,z|
      board.update!(x,"X")
      board.update!(y,"X")
      board.update!(z,"X")
      assert board.win?
      board.update!(x,x+1)
      board.update!(y,y+1)
      board.update!(z,z+1)
    end
  end

  def test_can_user_draw?
    board = Board.new
    refute board.draw?
    board.update!(0,"X")
    board.update!(1,"X")
    board.update!(2,"X")
    refute board.draw?

    # draw board = [ X O X
    #                O X O
    #                X O X]
    board.update!(0,"X")
    board.update!(1,"O")
    board.update!(2,"X")
    board.update!(3,"O")
    board.update!(4,"X")
    board.update!(5,"O")
    board.update!(6,"X")
    board.update!(7,"O")
    board.update!(8,"X")
    assert board.draw?
  end
end
