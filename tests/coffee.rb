class Coffee
 def initialize(name=nil)
   @name = name
   @level = 3
 end

 def name
   @name
 end

 def full?
  @level == 3
  end

 def empty?
   @level == 0
 end

 def drink!
  @level -= 1
 end
end
