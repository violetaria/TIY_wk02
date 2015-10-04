require 'pry'
require 'minitest/autorun'

require './player'
require './human'
require './random'
require './board'
require './game'
require './scoreboard'

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
    valid_moves = (1..9).to_a
    board = Board.new
    valid_moves.each do |spot|
      board.update!(spot,"X")
      assert_equal board.get_value(spot),"X"
    end
  end

  def test_can_detect_win?
    board = Board.new(3)
    refute board.win?
    board.update!(1,"X")
    board.update!(2,"X")
    board.update!(3,"X")
    assert board.win?
  end

  def test_can_detect_diagonal_win?
    board = Board.new(5)
    refute board.win?
    board.update!(1,"X")
    board.update!(7,"X")
    board.update!(13,"X")
    board.update!(19,"X")
    board.update!(25,"X")
    assert board.win?
  end

  def test_can_detect_vertical_win?
    board = Board.new(4)
    refute board.win?
    board.update!(3,"X")
    board.update!(7,"X")
    board.update!(11,"X")
    board.update!(15,"X")
    assert board.win?
  end

  def test_can_detect_horizontal_win?
    board = Board.new(10)
    refute board.win?
    board.update!(11,"X")
    board.update!(12,"X")
    board.update!(13,"X")
    board.update!(14,"X")
    board.update!(15,"X")
    board.update!(16,"X")
    board.update!(17,"X")
    board.update!(18,"X")
    board.update!(19,"X")
    board.update!(20,"X")
    assert board.win?
  end

  def test_can_detect_draw?
    board = Board.new(3)
    refute board.draw?
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
    valid_moves = (1..9).to_a
    board = Board.new
    move = valid_moves.sample
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

end

class ScoreBaordTest < MiniTest::Test
  def test_can_make_scoreboard
    scoreboard = ScoreBoard.new
    assert scoreboard
  end

  def test_can_update_wins
    scoreboard = ScoreBoard.new
    assert_equal scoreboard.wins,0
    scoreboard.add_win
    assert_equal scoreboard.wins,1
  end

  def test_can_update_losses
    scoreboard = ScoreBoard.new
    assert_equal scoreboard.losses,0
    scoreboard.add_loss
    assert_equal scoreboard.losses,1
  end

  def test_can_update_draws
    scoreboard = ScoreBoard.new
    assert_equal scoreboard.draws,0
    scoreboard.add_draw
    assert_equal scoreboard.draws,1
  end

end