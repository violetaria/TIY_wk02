require 'pry'

COMPUTER_NAME = "Unimatrix Zero"
PLAYER1_MARKER = "X"
PLAYER2_MARKER = "O"
WINNING_BOARDS = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
CENTER = 5
CORNERS =[1,3,7,9]
EDGES = [2,4,6,8]
EDGES_HASH = {2 => [1,3,5,8], 4 => [2,5,6,8], 6 => [3,4,5,9], 8 => [2,5,6,9]}

def show_board(board)
  puts "\n====== Current board ======"
  puts "
       #{board[0]} | #{board[1]} | #{board[2]}
       ---------
       #{board[3]} | #{board[4]} | #{board[5]}
       ---------
       #{board[6]} | #{board[7]} | #{board[8]}
       "
  puts "===========================\n"
end

def greeting
  puts "Welcome to Tic-Tac-Toe!"
  puts
  puts "Rules:
        Game supports 1 or 2 players.
        Players alternate turns.
        Player1 = Xs
        Player2 = Os

        Each position on the board is numbered.
        During your turn, enter a number which corresponds to an open position.
        If a number is replaced by an X or an O, that spot has already been claimed.
        Ready, Set, Go!
        "
  print "\nHow many players? (1 or 2) "
  num_players = gets.chomp.to_i
  until ((1..2).include?(num_players))
    puts "Please pick 1 or 2 players!"
    print "\nHow many players? (1 or 2) "
    num_players = gets.chomp.to_i
  end
  num_players
end

def get_player_name(player)
  print "Player #{player}, enter your name: "
  gets.chomp
end

def get_open_spots(board)
  board.select {|x| x.is_a?(Fixnum)}
end

def draw?(board)
  get_open_spots(board).empty?
end

def win?(board)
  WINNING_BOARDS.any? { |x,y,z| board[x]==board[y] && board[y]==board[z] }
end

def game_over?(board)
  win?(board) || draw?(board)
end

def get_picked(board,marker)
  picked_spots = []
  board.each_with_index {|value,index| picked_spots.push(index+1) if value==marker}
  picked_spots
end

def get_pick
  print "Select an open spot. Choose wisely: "
  gets.chomp.to_i
end

def find_wins(board,marker)
  open_spots = get_open_spots(board)
  wins = []
  open_spots.each do |spot|
    board[spot-1] = marker
    wins.push(spot) if win?(board)
    board[spot-1] = spot
  end
  wins
end

def first_pick(board)
  opponent_picks = get_picked(board,PLAYER1_MARKER)
  if opponent_picks.include?(CENTER)
    (CORNERS-opponent_picks).sample
  elsif !(opponent_picks & CORNERS).empty?
    CENTER
  else
    EDGES_HASH[opponent_picks[0]].sample
  end
end

def get_computer_pick(board)
  puts "Thinking...."
  sleep(1)
  puts "Thinking...."
  sleep(1)
  computer_picks = get_picked(board,PLAYER2_MARKER)
  if(computer_picks.empty?) #computers first move
    first_pick(board)
  else
    wins = find_wins(board,PLAYER2_MARKER)
    if !wins.empty?
      wins.sample
    else
      losses = find_wins(board,PLAYER1_MARKER)
      if !losses.empty?
        losses.sample
      else
        get_open_spots(board).sample
      end
    end
  end
end

def valid_pick?(pick,board)
  board.include?(pick)
end

def prompt_player(player,board)
  puts "#{player}, it's your turn!"
  player==COMPUTER_NAME ? pick=get_computer_pick(board) : pick=get_pick
  until valid_pick?(pick,board)
    puts "Hey! That is not an available spot!"
    # theoretically only a real player should get here
    pick=get_pick
  end
  pick
end

def take_turn(player,board,marker)
  show_board(board)
  pick = prompt_player(player,board)
  puts "#{player} chose #{pick}."
  update_board(pick,marker,board)
end

def update_board(pick,marker,board)
  board[pick-1] = marker
  board
end

def switch_player(current_player,player1,player2)
  current_player == player1 ? player2 : player1
end

def complete_game(board,current_player,player1,player2)
  show_board(board)
  if win?(board)
    # if there is a win, the player whose turn it WAS is the winner
    winner = switch_player(current_player,player1,player2)
    puts "\nCongrats #{winner}! You won the game!"
  else
    puts "It's a draw. You both lost :/"
  end
end

def play_again?
  puts "Play again? (y or n)"
  replay = gets.chomp.downcase
  until replay == "y" || replay == "n"
    puts "\nPlease enter y or n"
    puts "Play again? (y or n)"
    replay = gets.chop.downcase
  end
  replay == "y"
end

def tictactoe
  board = (1..9).to_a
  num_players = greeting
  player1 = get_player_name(1)
  player2 = num_players==2 ? get_player_name(2) : COMPUTER_NAME
  markers = {player1 => PLAYER1_MARKER, player2 => PLAYER2_MARKER}
  current_player = player1
  until game_over?(board)
    board = take_turn(current_player,board,markers[current_player])
    current_player = switch_player(current_player,player1,player2)
  end
  complete_game(board,current_player,player1,player2)
end

def play_tictactoe
  tictactoe
  while play_again?
    tictactoe
  end
end

play_tictactoe