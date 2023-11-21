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