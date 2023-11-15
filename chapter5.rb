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