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


class << Point # Syntax for adding methods to a single object
    def sum(*points) # This is the class method Point.sum x=y= 0
    points.each {|p| x += p.x; y += p.y }
    Point.new(x,y)
    end
    # Other class methods can be defined here 
end


class Test
    @@x = 10
    def initialize
        @y = 5
    end
    def intest(z)
        @@x += z
        @y += z
    end

    def out_x
        puts "x = #{@@x}"
    end
    def out_y
        puts "y = #{@y}"
    end
end

class Test1 < Test
    def intest(z)
        @@x -= z
        @y -= z
    end
end

a = Test.new
a.intest(5)
a.out_x # => 15
a.out_y # => 10
b = Test1.new
b.intest(10)
b.out_x # => 5
b.out_y # => -5

module Kernel
    # Constants defined in Kernel
    A = B = C = D = E = F = "defined in kernel"
end
    # Top-level or "global" constants defined in Object 
A = B = C = D = E = "defined at toplevel"
class Super
    # Constants defined in a superclass
    A = B = C = D = "defined in superclass"
end
module Included
    # Constants defined in an included module 
    A = B = C = "defined in included module"
end
module Enclosing
    # Constants defined in an enclosing module 
    A = B = "defined in enclosing module"
    class Local < Super 
        include Included
        # Locally defined constant 
        A = "defined locally"
        # The list of modules searched, in the order searched
        # [Enclosing::Local, Enclosing, Included, Super, Object, Kernel]
        search = (Module.nesting + self.ancestors + Object.ancestors).uniq
        puts A # Prints "defined locally"
        puts B # Prints "defined in enclosing module" 
        puts C # Prints "defined in included module" 
        puts D # Prints "defined in superclass"
        puts E # Prints "defined at toplevel"
        puts F # Prints "defined in kernel"
    end 
end