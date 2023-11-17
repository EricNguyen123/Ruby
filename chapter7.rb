# Classes and Modules----------------------------------------------------------------


class Point
    attr_accessor :x, :y # Define accessor methods for our instance variables
end
    
class Point
    attr_reader :x, :y # Define reader methods for our instance variables
end

class Point
    attr_reader :x, :y 
    def initialize(x,y)
        @x,@y = x, y 
    end
    def +(other) # Define + to do vector addition 
        Point.new(@x + other.x, @y + other.y)
    end
    def -@ # Define unary minus to negate both coordinates 
        Point.new(-@x, -@y)
    end
    def *(scalar) # Define * to perform scalar multiplication 
        Point.new(@x*scalar, @y*scalar)
    end 
end