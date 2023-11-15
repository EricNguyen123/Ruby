# Blocks and Iterators----------------------------------------------------------------

4.times {print "Hello, world!\n"}

1.upto(9) {|i| print i}

print "\n"

18.downto(9) { |i| print i}

print "\n"
# Array----------------------------------------------------------------
a = [1, 2, 3, 4, 5]

print a
print "\n"

b = a.map {|i| i*i}

print b
print "\n"

c =a.select {|i| i % 2 == 0}

print c
print "\n"


sum = a.inject do |sum, i|
    sum + i
end

print sum
print "\n"

# Object----------------------------------------------------------------

h = {
    :one => 1,
    :two => 2,
}

h[:three] = 3

h.each do |key, value|
    print "#{key} => #{value}\n"
end

# Expressions and Operators in Ruby(Biểu thức và toán tử)
# Method
# Assignment
# Punctuation Suffixes and Prefixes
# Regexp and Range

bar = {
    s: 2,
    v: 4
}
puts bar
