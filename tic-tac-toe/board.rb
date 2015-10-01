class Board
  def initialize
    @board = (1..9).to_a
  end

  # maybe move this to game?
  def display
    puts "
         | board[0] | board[1] | board[2] |
         | board[3] | board[4] | board[5] |
         | board[6] | board[7] | board[8] |
        "
  end

  def update(move,piece)
    @board[move-1] = piece
  end

  def get_value(spot)
    @board[spot-1]
  end

end