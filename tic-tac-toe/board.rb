WINNING_BOARDS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

class Board
  def initialize
    @board = (1..9).to_a
  end

  # maybe move this to game?
  def display
    puts "
         | #{@board[0]} | #{@board[1]} | #{@board[2]} |
         | #{@board[3]} | #{@board[4]} | #{@board[5]} |
         | #{@board[6]} | #{@board[7]} | #{@board[8]} |
        "
  end

  def update!(move,piece)
    @board[move] = piece
  end

  def get_value(spot)
    @board[spot]
  end

  def win?
    WINNING_BOARDS.any? do |x,y,z|
      @board[x]==@board[y] && @board[y]==@board[z]
    end
  end

  def draw?
    @board.all? do |x|
      x.is_a?(String)
    end
  end
end