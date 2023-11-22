# ---Reflection and Metaprogramming---

# ---instance_eval and class_eval----------------------------------------------------------------
o.instance_eval("@x") # Return the value of o's instance variable @x
String.class_eval("def len; size; end")
String.class_eval("alias len size")
String.instance_eval("def empty; ''; end")

o.instance_eval { @x } 
String.class_eval {
    def len 
        size
    end 
}
String.class_eval { alias len size } 
String.instance_eval { def empty; ""; end }


# ---Variables and Constants----------------------------------------------------------------

global_variables # => ["$DEBUG", "$SAFE", ...]
x = 1 # Define a local variable
local_variables # => ["x"]
# Define a simple class 
class Point
    def initialize(x,y); @x,@y = x,y; end # Define instance variables 
    @@classvar = 1 # Define a class variable 
    ORIGIN = Point.new(0,0) # Define a constant
end
Point::ORIGIN.instance_variables # => ["@y", "@x"] 
Point.class_variables # => ["@@classvar"] 
Point.constants # => ["ORIGIN"]

# ---Querying, Setting, and Testing Variables----------------------------------------------------------------

x= 1
varname = "x"
eval(varname) # => 1
eval("varname = '$g'") # Set varname to "$g" 
eval("#{varname} = x") # Set $g to 1 
eval(varname) # => 1

o = Object.new
o.instance_variable_set(:@x, 0) # Note required @ prefix 
o.instance_variable_get(:@x) # => 0
o.instance_variable_defined?(:@x) # =>true
Object.class_variable_set(:@@x, 1) # Private in Ruby 1.8
Object.class_variable_get(:@@x) # Private in Ruby 1.8
Object.class_variable_defined?(:@@x) #=> true; Ruby 1.9 and later



Math.const_set(:EPI, Math::E*Math::PI) 
Math.const_get(:EPI) # => 8.53973422267357 
Math.const_defined? :EPI # => true


# ---Listing and Testing For Methods----------------------------------------------------

o = "a string"
o.methods 
o.public_methods 
o.public_methods(false) 
o.protected_methods 
o.private_methods 
o.private_methods(false) 
def o.single; 1; end 
o.singleton_methods


String.instance_methods == "s".public_methods # => true 
String.instance_methods(false) == "s".public_methods(false) # => true 
String.public_instance_methods == String.instance_methods # => true 
String.protected_instance_methods # => [] 
String.private_instance_methods(false) # => ["initialize_copy",
                                        # "initialize"]


String.public_method_defined? :reverse # => true 
String.protected_method_defined? :reverse # => false 
String.private_method_defined? :initialize # => true 
String.method_defined? :upcase! # => true

# ---Obtaining Method Objects----------------------------------------------------------------

"s".method(:reverse) # => Method object 
String.instance_method(:reverse) # => UnboundMethod object

# ---Defining, Undefining, and Aliasing Methods----------------------------------------------------------------

def add_method(c, m, &b)
    c.class_eval { define_method(m, &b)
    } 
end
add_method(String, :greet) { "Hello, " + self } 
"world".greet # => "Hello, world"

def add_class_method(c, m, &b) 
    eigenclass = class << c; self; end 
    eigenclass.class_eval {define_method(m, &b) }
end
add_class_method(String, :greet) {|name| "Hello, " + name } 
String.greet("world") # => "Hello, world"

def backup(c, m, prefix="original")
    n = :"#{prefix}_#{m}" # Compute the alias
    c.class_eval {
        alias_method n, m # Make n an alias for m 
    }
end
backup(String, :reverse) 
"test".original_reverse

# ---Handling Undefined Methods----------------------------------------------------------------

class Hash
    # Allow hash values to be queried and set as if they were attributes. # We simulate attribute getters and setters for any key.
    def method_missing(key, *args)
        text = key.to_s
        if text[-1,1] == "="
            self[text.chop.to_sym] = args[0] # Strip = from key
        else self[key]
        end 
    end
end
h = {} 
h.one = 1 
puts h.one

# ---Setting Method Visibility----------------------------------------------------------------

String.class_eval { private :reverse }
"hello".reverse # NoMethodError: private method 'reverse'

# ---Hooks----------------------------------------------------------------

def Object.inherited(c)
    puts "class #{c} < #{self}"
end

# Included

# Declaring a module to greet a person
module Greetings

    def self.included(person_to_be_greeted) 
        
        puts "The #{person_to_be_greeted} is welcomed with an open heart !"
    end
end
    
    
    # Class where the module is included
class Person
    include Greetings # implementation of the include statement
end
    

# Prepended

# Code as an example for prepend method
module Ruby

    def self.prepended(target)# Implementation of prepend method
        puts "#{self} has been prepended to #{target}"
    end
    
    def Type
        "The Type belongs to Ruby"
    end
end
    
class Coding
    
    prepend Ruby # the module Ruby is prepended
end
    
    # Method call
puts Coding.new.Type 
    
# Extended

# Code as an example for extend method
module Ruby

    def self.extended(target)
        puts "#{self} was extended by #{target}"
    end
    
    def Type
        "The Type is Ruby"
    end
end
    
class Coding
    
    extend Ruby # Extending the module Ruby
end
    
    # Method calling
puts Coding.Type
    
# Inherited
# Making the parent Vehicle class
class Vehicle

    def self.inherited(car_type)
        puts "#{car_type} is a kind of Vehicle"
    end
    
end
    
    # Target class
class Hyundai < Vehicle #Inhereting the Vehicle class
end
    
# method_missing

# The main class
class Ruby

    def method_missing(input, *args) # method_missing function in action
        "#{input} not defined on #{self}"
    end
    
    def Type
        "The Type is Ruby"
    end
end
    
var = Ruby.new
    
    # Calling a method that exists
puts var.Type 
    
    # Calling a method that does not exist
puts var.Name 
    
#--- Custom Control Structures----------------------------------------------------------------

# Delaying and Repeating Execution: after and every

require 'afterevery'
1.upto(5) {|i| after i { puts i} } 
sleep(5)
every 1, 6 do |count|
    puts count
    break if count == 10 
    count + 1
end 
sleep(6)
