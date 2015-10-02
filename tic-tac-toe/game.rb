require './scoreboard'

class Game
  def initialize(player1,player2,board)
    @player1 = player1
    @player1.token = "X"
    @player2 = player2
    @player2.token = "O"
    @board = board
    @current_player = @player1
    @player1_scoreboard = ScoreBoard.new
    @player2_scoreboard = ScoreBoard.new
  end

  def play
    @board.display  # display initial board
    until game_over?
      take_turn
      @board.display
    end
    print_game_results
    update_score
    display_scoreboard
  end

  def reset!
    @board = Board.new
    @current_player = @player1
  end

  private

  def display_scoreboard
    puts "_____________________________________"
    puts "#{@player1.name} [#{@player1.token}] Scoreboard"
    @player1_scoreboard.display_scoreboard
    puts "-------------------------------------"
    puts "#{@player2.name} [#{@player2.token}] Scoreboard"
    @player2_scoreboard.display_scoreboard
    puts "_____________________________________"
    puts
  end

  # this assumes it's run after the print_game_results
  # print_game_results should have already switched current_player to the winning player
  def update_score
    if @board.draw?
      @player1_scoreboard.add_draw
      @player2_scoreboard.add_draw
    else
      if @current_player == @player1
        @player1_scoreboard.add_win
        @player2_scoreboard.add_loss
      else
        @player2_scoreboard.add_win
        @player1_scoreboard.add_loss
      end
    end
  end

  def prompt_player
    puts "#{@current_player.name} [#{@current_player.token}], it's your turn!"
  end

  def switch_current_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def print_game_results
    switch_current_player
    puts @board.win? ? "Congrats #{@current_player.name} [#{@current_player.token}]!  You won!" : "It's a draw."
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

  def game_over?
    @board.win? || @board.draw?
  end

  def take_turn
    prompt_player
    move = @current_player.get_move
    until @board.valid_move?(move)
      puts "#{move} is not a valid move.  Choose again."
      move = @current_player.get_move
    end
    @board.update!(move,@current_player.token)
    switch_current_player
  end

end
