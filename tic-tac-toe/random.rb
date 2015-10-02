class RandomPlayer < Player
  def initialize
    @name = "Unimatrix Zero"
    @valid_moves = (1..9).to_a
  end

  def get_move
    move = @valid_moves.sample
    puts "#{@name} chose #{move}"
    move
  end
end