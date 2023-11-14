
10.times { puts "test".object_id }

s = "¥1000"
s.each_char {|x| print "#{x} " } 
0.upto(s.size-1) {|i| print "#{s[i]} "}

# # Here documents
# greeting = <<HERE + <<THERE + "World" 
# Hello
# HERE
# There
# THERE

# puts greeting

# Object 
puts ""



# Object References----------------------------------------------------------------
s = "abcdef"
t = s
t[-1] = ""

print s 


# Object Identity----------------------------------------------------------------
a = 1
puts "object_id of a: #{a.object_id}"


# Object Class and Object Type----------------------------------------------------------------

class A
end
class B < A
end
class C < B
end

b = B.new
puts "instance_of? (class) :"
puts b.instance_of? A   #=> false
puts b.instance_of? B   #=> true
puts b.instance_of? C   #=> false

module M   
end
class A
  include M
end
class B < A
end
class C < B
end

b = B.new
puts "is_a? (class):"
puts b.is_a? A          #=> true
puts b.is_a? B          #=> true
puts b.is_a? C          #=> false
puts b.is_a? M          #=> true


# Object Equality----------------------------------------------------------------
a = "aa"
b = "aa"
puts "Object Equality"
puts a.equal? (b) # có tham chiếu đến cùng object hay không

puts a == b # hai tham chiếu của các object có giống nhau không

puts a.eql?(b)   # Phương thức eql? được định nghĩa bởi object như một 
            # từ đồng nghĩa với equal?. Các lớp ghi đè nó thường sử dụng nó 
            # như một phiên bản nghiêm ngặt của == không chuyển đổi kiểu
puts a===b 


# The !~ operator
# Trả về true nếu hai đối tượng không khớp nhau (sử dụng phương thức =~), nếu không thì trả về false.

# Object Order--------------------------------------------------------
3 <=> 4 # -1
6 <=> 6 # 0
9 <=> 5 #1 

"1" <=> 5 # nil: integers and strings are not comparable


# Object Conversion--------------------------------------------------------

#Explicit conversions: to_s, to_i, to_f, and to_a to convert to String, Integer, Float, and Array
# Implicit conversions:

e = Exception.new("not really an exception")
msg = "Error: " + e 
