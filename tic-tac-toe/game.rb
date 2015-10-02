class Game
  def initialize(player1,player2,board)
    @player1 = player1
    @player2 = player2
    @board = board
  end

  def game_over?
    @board.win? || @board.draw?
  end

end