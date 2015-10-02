class Game
  def initialize(player1,player2,board)
    @player1 = player1
    @player1.token = "X"
    @player2 = player2
    @player2.token = "O"
    @board = board
    @current_player = @player1
  end



  def game_over?
    @board.win? || @board.draw?
  end

  def current_player
    @current_player
  end

  def take_turn
    # does this need to be a function? (we had prompt player before)
    move = @current_player.get_move
    until @board.valid_move?(move)
      puts "That is not a valid move.  Choose again."
      move = @current_player.get_move
    end
    @board.update!(move,@current_player.token)
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end