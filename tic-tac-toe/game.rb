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
    puts "#{@current_player.name} using #{@current_player.token}'s, it's your turn!"
    move = @current_player.get_move
    until @board.valid_move?(move)
      puts "#{move} is not a valid move.  Choose again."
      move = @current_player.get_move
    end
    @board.update!(move,@current_player.token)
    switch_current_player
  end

  def play
    until self.game_over?
      @board.display
      self.take_turn
      @board.display
    end
    print_game_results
  end

  private
  def switch_current_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def print_game_results
    switch_current_player
    puts @board.win? ? "Congrats #{@current_player.name}!  You won!" : "It's a draw."
  end

end