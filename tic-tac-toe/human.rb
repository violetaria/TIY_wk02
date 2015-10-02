class HumanPlayer < Player
  def initialize(name=nil)
    @name = name.nil? ? get_name : name
  end

  def get_move
    print "\nPlease pick an open spot: "
    move = gets.chomp.to_i
    puts "#{@name} chose #{move}"
    move
  end

  private
  def get_name
    print "Please enter your name: "
    @name = gets.chomp
  end
end