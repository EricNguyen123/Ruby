# The Ruby Platform----------------------------------------------------------------

# Strings

s = "hello" 
puts s
s.concat(" world") 
puts s
s.insert(5, " there") 
puts s
s.slice(0,5) 
puts s.slice(0,5) 
s.slice!(5,6) 
puts s
s.eql?("hello world")


puts s.length 
puts s.size 
puts s.bytesize 
puts s.empty? 
puts "".empty?

s = "hello"
# Finding the position of a substring or pattern match
s.index('l') 
s.index(?l) 
s.index(/l+/) 
s.index('l',3) 
s.index('Ruby') 
s.rindex('l') 
s.rindex('l',2)

s.start_with? "hell" # => true. Note singular "start" not "starts" 
s.end_with? "bells"

s.include?("ll") # => true: "hello" includes "ll"
s.include?(?H)


s =~ /[aeiou]{2}/ # => nil: no double vowels in "hello" 
s.match(/[aeiou]/) {|m| m.to_s}


"this is it".split # => ["this", "is", "it"]: split on spaces by default "hello".split('l') # => ["he", "", "o"]
"1, 2,3".split(/,\s*/) # => ["1","2","3"]: comma and optional space delimiter

"banana".partition("an") # => ["b", "an", "ana"] 
"banana".rpartition("an") # => ["ban", "an", "a"]: start from right 
"a123b".partition(/\d+/) # => ["a", "123", "b"]: works with Regexps, too
s = "abcde"
s.sub("l", "L") 
s.gsub("l", "L") 
puts s.sub!(/(.)(.)/, '\2\1')
puts s.sub!(/(.)(.)/, "\\2\\1")

"hello world".gsub(/\b./) {|match| match.upcase }

s = "world" 
s.upcase 
s.upcase! 
s.downcase 
s.capitalize 
s.capitalize! 
s.swapcase

# so sánh chuỗi không phân biệt kí tự hoa hay thường
"world".casecmp("WORLD") # => 0
"a".casecmp("B") # => -1

# loại bỏ kí tự xuống dòng cuối chuỗi
s = "hello\r\n" 
s.chomp! 
s.chomp 
s.chomp! 
s.chomp("o")
puts s
$/ = ";" 
puts "hello;".chomp

# loại bỏ kí tự cuối cùng của chuỗi bất kể là ký tự nào.
s = "hello\n"
s.chop! # => "hello": line terminator removed. s modified. 
s.chop # => "hell": last character removed. s not modified. 
"".chop # => "": no characters to remove
"".chop!

# Loại bỏ khoảng trắng
s = "\t hello \n" 
s.strip
s.lstrip
s.rstrip

s = "x" 
s.ljust(3) 
s.rjust(3) 
s.center(3) 
s.center(5,'-') 
s.center(7, '-=')
# => "x  "
# => "  x"
# => " x "
# => "--x--": padding other than space are allowed 
# => "-=-x-=-": multicharacter padding allowed

s = "A\nB" # Three ASCII characters on two lines 
s.each_byte {|b| print b, " " } # Prints "65 10 66 "
s.each_line {|l| print l.chomp} # Prints "AB"

s.each_char { |c| print c, " " } # Prints "A \n B "

0.upto(s.length-1) {|n| print s[n,1], " "}

s.bytes.to_a
s.lines.to_a
s.chars.to_a


"10".to_i 
"10".to_i(2) 
"10x".to_i
" 10".to_i 
"ten".to_i 
"10".oct 
"10".hex 
"0xff".hex
" 1.1 dozen".to_f 
"6.02e23".to_f


"one".to_sym 
"two".intern

"a".succ # => "b": the successor of "a". Also, succ! 
"aaz".next # => "aba": next is a synonym. Also, next! 
"a".upto("e") {|c| print c }

"hello".reverse
"hello\n".dump 
"hello\n".inspect

"hello".tr("aeiou", "AEIOU") # => "hEllO": capitalize vowels. Also tr! 
"hello".tr("aeiou", " ") # => "h ll ": convert vowels to spaces

"hello".crypt("ab") # để mã hoá chuỗi

"hello".count('aeiou') # => 2: count lowercase vowels 
"hello".delete('aeiou') # => "hll": delete lowercase vowels. Also delete! 
"hello".squeeze('a-z') 

# Arguments that begin with ^ are negated. ^ thể hiện phủ nhận
"hello".count('a-z', '^aeiou') # => 3: count lowercase consonants 
"hello".delete('a-z', '^aeiou') # => "eo: delete lowercase consonants

# Formatting Text

# Packing and Unpacking Binary Strings

a = [1,2,3,4,5,6,7,8,9,10] 
b = a.pack('i10')
c = b.unpack('i*')
c == a

m = 'hello world'
data = [m.size, m] 
template = 'Sa*'
b = data.pack(template) 
b.unpack(template)

# Pattern matching with strings

"ruby123"[/\d+/] # "123" 
"ruby123"[/([a-z]+)(\d+)/,1] # "ruby" 
"ruby123"[/([a-z]+)(\d+)/,2] # "123"

r = "ruby123"
r.slice!(/\d+/) 

s = "one, two, three"
s.split
s.split(", ")  
s.split(/\s*,\s*/)

text = "hello world"
pattern = /l/
first = text.index(pattern)
n = Regexp.last_match.end(0) 
second = text.index(pattern, n) 
last = text.rindex(pattern)

# Search and replace

# phone = gets 
# phone.sub!(/#.*$/, "") 
# phone.gsub!(/\D/, "")

a = [4,5] 
a.replace([1,2,3]) 
a.fill(0) 
a.fill(nil,1,3) 
puts a
a.fill('a',2..4) 
puts a
a[3].upcase! # a now holds [0,nil,'A','A','A'] các phần tử đều tham chiếu tới cùng "a" do cách a.fill('a',2..4) thực hiện
puts a
a.fill(2..4) { 'b' } 
puts a
a[3].upcase! # a now holds [0,nil,'b','B','b']
puts a
a.compact
a.compact! 
a.clear

# Associative array methods
h = { :a => 1, :b => 2} 
a = h.to_a
a.assoc(:a) 
a.assoc(:b).last 
a.rassoc(1) 
a.rassoc(2).first 
a.assoc(:c)
a.transpose

empty = Hash.new(-1) 
puts empty["two"]
puts empty.default