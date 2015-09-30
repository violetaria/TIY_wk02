class Human
 def initialize(name=nil)
   @name = name
   @alertness = 0 # Not alert
   @coffees = []
 end

  def alertness
    @alertness
  end

  def has_coffee?
    @coffees.length != 0
  end

  def needs_coffee?
    @alertness == 0 # may need to make this < 0.9
  end

  def buy(coffee)
    @coffees.push(coffee)
  end

  def drink!
    @coffees[0].drink!
    @coffees.pop if(@coffees[0].empty?)
    @alertness += 0.333
  end
end
