# ------- Expressions and Operators --------------------------------

=begin 
keywords:
    - nill
    - true
    - false
    - self
    - __FILE__
    - __LINE__
    - __ENCODING__
    
    
    *  Uninitialized Variables ****************
    - Class variables: các biến phải luôn được khởi tạo trước khi sử dụng nếu không sẽ NameError
    - Instance variables: biến này chưa được khởi tạo Ruby sẽ trả về nil
    - Global variables: tương tự Instance variables
    - Local variables: Trả về NameError nếu không tìm được giá trị khởi tạo hoặc một method có tên như vậy.

=end

#  Constant References ----------------------------------------------------------------


puts "Constant References---"
CM_BOX = 24.5
puts CM_BOX

#  :: dùng để tách tên của hằng số khỏi class hoặc mdule mà nó được định nghĩa

module Cmt
    X_CMT = 26
end


puts ::CM_BOX
# puts X_CMT    # NameError do value đang định nghĩa trong class or method và bên ngoài chưa khởi tạo.
# puts ::X_CMT  # NameError do value đang định nghĩa trong class or method và bên ngoài chưa khởi tạo.
puts Cmt::X_CMT



# Method Invocations----------------------------------------------------------------


# Gọi bằng . or :: 
# yield + keyword :để đưa keyword vào khối {} của phương thức khi gọi. 
# Có khả năng tự định nghĩa cách dùng keyword cho các trường hợp khác nhau.

# Ex:
puts "Method Invocations---"
message = "hello world"
puts message 
Math.sqrt(2) 
puts message.length 
a = [1, 2, 3, 4]
a.each {|x| p x }

# Assignments -------------------------------------------------------------------------

puts "Assignments---"
# Ex:
x = 1
puts x
x += 1
puts x
x, y, z = 1, 2, 3
puts "x = #{x} , y = #{y}, z = #{z}"

x = y = 0
puts "x = #{x} , y = #{y}"

# Same number of lvalues and rvalues

x,y = y,x # Parallel: swap the value of two variables 
x = y; y = x # Sequential: both variables have same value

# The splat operator
x, y, z = 1, *[2,3] # Same as x,y,z = 1,2,3

x,*y = 1, 2, 3 # x=1; y=[2,3] 
x,*y = 1, 2 # x=1; y=[2] 
x,*y = 1 # x=1; y=[]

*x,y = 1, 2, 3 # x=[1,2]; y=3 
*x,y = 1, 2 # x=[1]; y=2 
*x,y = 1 # x=[]; y=1

x, y, *z = 1, *[2,3,4] # x=1; y=2; z=[3,4].

# Parentheses in parallel assignment
x,y,z = 1,[2,3] # No parens: x=1;y=[2,3];z=nil
x,(y,z) = 1,[2,3]  # Parens: x=1;y=2;z=3
a,b,c,d = [1,[2,[3,4]]] # No parens: a=1;b=[2,[3,4]];c=d=nil
a,(b,(c,d)) = [1,[2,[3,4]]] # Parens: a=1;b=2;c=3;d=4

# The defined? Operator
v = [1,2,3,4]
puts v if defined?(v)