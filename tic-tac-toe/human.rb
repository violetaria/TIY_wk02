class HumanPlayer < Player
  def initialize(name=nil)
    @name = name.nil? ? get_name : name
  end

  def get_move
    print "Please pick an open spot: "
    gets.chomp.to_i
  end

  private
  def get_name
    print "Please enter your name: "
    @name = gets.chomp
  end
end