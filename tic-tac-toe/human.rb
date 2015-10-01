class Human < Player
  def initialize(name=nil)
    @name = name.nil? ? get_name : name
  end

  private
  def get_name
    print "Please enter your name: "
    @name = gets.chomp
  end
end