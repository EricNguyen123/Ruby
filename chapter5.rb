# -----Statements and Control Structures--------------------------------

# Conditionals----------------------------------------------------------------

# If --- 
puts "if"
x = 1
if x 
    puts "x = #{x}"
end

# else ---
puts "else"

y = 2

if y < x 
    puts "y < x"
else 
    puts "y > x"
end

#  elsif ---
puts "elsif"

z = 3
if y < x 
    puts "y < x"
elsif y < z
    puts "y < z"
end

# Return value ---
puts "Return value"
x = rand(10)
y = rand(10)
a = if x < y then "x < y"
    elsif x == y then "x == y"
    else "x > y"
    end
puts "x = #{x}, y = #{y} => #{a}"

# if As a Modifier---
puts "if As a Modifier"
class Check
    def initialize(name)
        @name = name
    end

    def num_x
        return @name if @name != ""
    end
end

num = Check.new("hello world")

puts num.num_x

y_num = num.num_x if num.respond_to?(:num_x)

puts "y_num = #{y_num}"

z_num = (num.num_y if num.respond_to?(:num_y))

puts "z_num = #{z_num}" # num_y không có nên z_num = nil

# unless---
puts "unless"
x = [1, 3, 10, 20]

x.each do |i| 
    unless i > 10
        puts "x = #{i}" 
    end
end

# case---

puts "case"
x = "Hi"

inp = gets.chomp
puts inp
x = case 
    when 1 == inp.to_i
        x = x << " one"
    when 2 == inp.to_i
        x = x << " two"     
    else
        x = x << " nil"
    end

puts "x = #{x}"

# The ?: Operator---

puts "The ?: Operator"
def check(v)
    res = (v == 1) ? "one" : (v == 2) ? "two" : "nil"
    return res
end

puts "check = #{check(inp.to_i)}"



# ---Loops---

# while and until---

x = [1, 2, 3, 4, 5]
puts "while"
i = 0
while (x[i] < 3) do
    puts x[i]
    i += 1
end


puts "until"
i = x.length - 1
until (x[i] < 3) do
    puts x[i]
    i -= 1
end

# while and until As Modifiers---
puts "while and until As Modifiers"

x = 0
puts x = x + 1 while (x < 6)

x = 0
puts x = x + 1 until (x > 3)

# The for/in Loop---

puts "The for/in Loop"

array = [1, 2, 3, 4]

for i in array
    puts i
end

hash = {one: 1, two: 2, three:3}

for key, value in hash
    puts "#{key} => #{value}" 
end

hash.each do |key, value|
    puts "#{key} => #{value}" 
end 

# Iterators and Enumerable Objects---
puts "Iterators and Enumerable Objects"

3.times { puts "hello"}

2.upto(6) {|i| puts i}

data = [1, 2, 3, 4]
data.each do |i|
    puts i 
end

data.map {|i| puts i * i}

# Enumerable Objects---
puts "Enumerable Objects"
squares = [1,2,3].collect {|x| x*x} # => [1,4,9]
evens = (1..10).select {|x| x%2 == 0} # => [2,4,6,8,10]
odds = (1..10).reject {|x| x%2 == 0} # => [1,3,5,7,9]
c = (1..10).inject(:+) 
puts c
d = (1..10).inject {|a,b| a + b}
puts d
e = (1..10).inject(11) {|a,b| a + b}
puts e
f = (1..10).inject(11, :+)
puts f

# Writing Custom Iterators---

puts "Writing Custom Iterators"

def write_custom(s, i)
    while i < 5
        yield "#{s} #{i}"
        i += 1 
    end
end

write_custom("Hello", 1) {|x| puts x}

# Enumerators---
puts "Enumerators"
data = [1, 2, 3, 4, 5]

data.enum_for.each {|x| puts x}
data.to_enum.each {|x| puts x} #tương tự như enum_for

# Nếu sử dụng với data là một String ta có các method each_char, each_byte, and each_line

data = "hello"
data.to_enum(:each_char).each {|x| puts x}

# External Iterators---
puts "External Iterators"
iterator = 9.downto(1)
loop do 
    print iterator.next 
end
puts "...blastoff!"

# Iteration and Concurrent Modification---
puts "Iteration and Concurrent Modification"

a = [1,2,3,4,5]
a.each {|x| puts "#{x},#{a.shift}" } #each lặp theo index khi phần tử đầu bị loại bỏ, index vẫn tiếp tục
# index = 0 in ra 1 a.shift loại bỏ 1 khỏi mảng 
# lần lặp tiếp theo index = 1 nhưng mảng chỉ còn [2, 3, 4, 5] nên tại index = 1 in ra 3 và a.shift loại bỏ 2 khỏi mảng ... tương tự cho những lần tiếp theo.
b = [1, 2, 3, 4, 5]
module Num
    def each_in_snapshot &block
        snapshot = self.dup 
        snapshot.each &block 
    end
end

b.extend(Num)
b.each_in_snapshot {|x| puts "#{x},#{b.shift}" }

if b.empty? 
    puts "b = []"
end

# Altering Control Flow---
=begin 
return
    Causes a method to exit and return a value to its caller.
break
    Causes a loop (or iterator) to exit.
next
    Causes a loop (or iterator) to skip the rest of the current iteration 
    and move on to the next iteration.
redo
    Restarts a loop or iterator from the beginning.
retry
    Restarts an iterator, reevaluating the entire expression. 
    The retry keyword can also be used in exception handling, 
    as we’ll see later in the chapter.
throw/catch
    A very general control structure that is named like and 
    works like an exception propagation and handling mechanism. throw 
    and catch are not Ruby’s primary exception mechanism (that would 
    be raise and rescue, described later in this chapter). Instead, they 
    are used as a kind of multilevel or labeled break.
=end


i = 0
while i < 3
    print i
    i += 1
    redo if i == 3
end


=begin 
    def method_name(x)
        # The body of the method goes here.
        # Usually, the method body runs to completion without exceptions # and returns to its caller normally.
    rescue
        # Exception-handling code goes here.
        # If an exception is raised within the body of the method, or if # one of the methods it calls raises an exception, then control # jumps to this block.
    else
        # If no exceptions occur in the body of the method # then the code in this clause is executed.
    ensure
        # The code in this clause is executed no matter what happens in the
        # body of the method. It is run if the method runs to completion, if
        # it throws an exception, or if it executes a return statement.
    end
=end

# Threads, Fibers, and Continuations
f = Fiber.new {
puts "Fiber says Hello" 
Fiber.yield
puts "Fiber says Goodbye"
}
puts "Caller says Hello" 
f.resume
puts "Caller says Goodbye" 
f.resume


f = Fiber.new do |message|
    puts "Caller said: #{message}" 
    message2 = Fiber.yield("Haha") 
    puts "Caller said: #{message2}" 
    "Fine"
    end
response = f.resume("Hi") 
puts "Fiber said: #{response}"
response2 = f.resume("How are you?") 
puts "Fiber said: #{response2}"  