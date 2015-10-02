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
    prompt_player
    move = @current_player.get_move
    until @board.valid_move?(move)
      puts "#{move} is not a valid move.  Choose again."
      move = @current_player.get_move
    end
    @board.update!(move,@current_player.token)
    switch_current_player
  end

  def play
    @board.display  # display initial board
    until self.game_over?
      self.take_turn
      @board.display
    end
    print_game_results
    # if play_again?
    #   self.reset!
    #   self.play
    # end
  end

  def play_again
    reset!
    play
  end

  private
  def reset!
    @board = Board.new
    @current_player = @player1
  end

  def prompt_player
    puts "#{@current_player.name} using #{@current_player.token}'s, it's your turn!"
  end

  def switch_current_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def print_game_results
    switch_current_player
    puts @board.win? ? "Congrats #{@current_player.name}!  You won!" : "It's a draw."
  end

  def greeting
    puts "Welcome to Tic-Tac-Toe!"
    puts
    puts "Rules:
        Game supports 0 to 2 human players.
        Non-human players will be replaced by Computer players.
        Players alternate turns.
        Player1 = Xs
        Player2 = Os

        Each position on the board is numbered 1 to 9.
        During your turn, enter a number which corresponds to an open position.
        If a number is replaced by an X or an O, that spot has already been claimed.
        Ready, Set, Go!
        "
  end
end
