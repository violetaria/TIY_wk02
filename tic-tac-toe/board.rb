#WINNING_BOARDS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

class Board
  def initialize(n=3)
    @size = n
    @board = (1..(n*n)).to_a
    @winning_boards = get_winning_boards
  end

  def display
  ## this really only works up to a certain point
    puts
    @size.times do |x|
      @size.times do |y|
        position = (x*@size)+y
        if(position < 10)
          print "|  #{@board[position]}  "
        elsif(position < 99)
          print "| #{@board[position]}  "
        else
          print "| #{@board[position]} "
        end
      end
      puts "|"
    end
    puts
  end

  def update!(move,piece)
    @board[move-1] = piece
  end

  def get_value(spot)
    @board[spot-1]
  end

  def win?
    @winning_boards.any? do |win|
      check_value = @board[win[0]]
      win.all? do |spot|
        @board[spot] == check_value
      end
    end
  end

  def draw?
    @board.all? do |x|
      x.is_a?(String)
    end
  end

  def valid_move?(move)
    @board.include?(move)
  end

  private
  def calculate_diagonal_wins
    diagonal_wins = [[],[]]
    @size.times do |x|
      diagonal_wins[0].push((x*@size)+(x))
      diagonal_wins[1].push(x*2+@size - 1)
    end
    diagonal_wins
  end

  def calculate_horizontal_wins
    horizontal_wins = []
    @size.times do |x|
      win = []
      @size.times do |y|
        win.push((x*@size)+y)
      end
      horizontal_wins.push(win)
    end
    horizontal_wins
  end

  def calculate_vertical_wins
    vertical_wins = []
    @size.times do |x|
      win = []
      @size.times do |y|
        win.push(x+(y*@size))
      end
      vertical_wins.push(win)
    end
    vertical_wins
  end

  def get_winning_boards
    @winning_boards = calculate_horizontal_wins + calculate_vertical_wins + calculate_diagonal_wins
  end

end