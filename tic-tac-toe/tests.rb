require 'minitest/autorun'

require './player'
require './human'
require './random'

class PlayerTest < MiniTest::Test
  def test_can_make_player
    named_player = Player.new("Terri")
    assert_equal(named_player.name, "Terri")

    unnamed_player = Player.new
    assert_equal(unnamed_player.name,"Unimatrix Zero")
  end
end

class HumanPlayerTest < MiniTest::Test
  def setup
    @named_human_player = HumanPlayer.new("Terri")
  end
  def test_can_make_human_player
    assert_equal(@named_human_player.name,"Terri")

    HumanPlayer.stub :new, "Yang" do
      unnamed_human_player = HumanPlayer.new
      refute_equal(unnamed_human_player ,"Unimatrix Zero")
    end
  end

  def test_can_human_get_move
    ## TODO
  end
end

class RandomPlayerTest < MiniTest::Test
  def setup
    @player = RandomPlayer.new
  end

  def test_can_make_random_player
    assert_equal(@player.name,"Unimatrix Zero")
  end

  def test_can_random_get_move
    move = @player.get_move
    valid_move = (1..9).to_a
    100.times { assert_includes(valid_move,move) }
  end
end
