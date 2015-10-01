class RandomPlayer < Player
  def initialize
    @name = "Unimatrix Zero"
    @valid_moves = (1..9).to_a
  end

  def get_move
    @valid_moves.sample
  end
end