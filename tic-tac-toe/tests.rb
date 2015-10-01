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
    @board = Board.new
  end
  def test_can_make_board
    assert @board
  end

  def test_can_display_board
    assert_output(/^[|\s1-9]+$/) { @board.display }
  end
end
