# Methods, Procs, Lambdas, and Closures --------------------------------


=begin 
- Một phương (method) thức là một khối được đặt tên của mã được tham số hóa được 
liên kết với một hoặc nhiều đối tượng.

=end

# Defining Singleton Methods ---

x = "Hello"

def x.printStr
    v = self + " world!"
    puts v
end

x.printStr


class People
    def initialize(data)
        @name, @age, @city = data[:name], data[:age], data[:city]
        random = Random.new
        @id = @city + random.rand(100..999).to_s + @name + @age.to_s
    end

    def get_people()
        return {:id => @id, :name => @name, :age => @age, :city => @city}
    end

    def set_name(name)
        @name = name
    end

    def set_age(age)
        @age = age
    end

    def set_city(city)
        @city = city
    end

end

class City

    def initialize(name_city, peoples = [])
        @name_city = name_city
        @total_people = peoples.count
        @peoples = peoples
    end

    def get_city()
        return {:nameCity => @name_city, :totalPeople => @total_people, :peoples => @peoples}
    end

    def set_people(peoples)
        peoples.each do |p|
            if p[:city] == @name_city
                @peoples.push(p)
            end
        end
        @total_people = @peoples.count
    end

    def +(newCity)
        newCity = newCity.get_city()
        newCity[:peoples].each do |people|
            people[:city] = @name_city
            @peoples.push(people)
        end
        return City.new(self.get_city()[:name_city], self.get_city()[:peoples])
    end
end

a = People.new({name: "a", age: 18, city: "HN"})
b = People.new({name: "b", age: 21, city: "HN"})
c = People.new({name: "c", age: 19, city: "ND"})
d = People.new({name: "d", age: 22, city: "NB"})
n = []
n.push(a.get_people())
n.push(b.get_people())
n.push(c.get_people())
n.push(d.get_people())
puts n

q = City.new("HN")
q.set_people(n)
puts q.get_city()

w = City.new("NB")
w.set_people(n)
puts w.get_city()

# q.add(w)
q = q + w
puts q.get_city()


# proc
puts "search"
def search_people(name, peoples)
    search = Proc.new {|x| return x if x[:name] == name}
    return peoples.each(&search)
end

puts search_people("a", q.get_city()[:peoples])

# lambda

lam = lambda {|x, y| x + y}

puts lam.call(1, 2) 

# lambda là một phần của proc tuy nhiên khác biệt là 
# lambda yêu cầu nghiêm ngặt hơn về số lượng đối số được khai báo và truyền vào.

# Closures and Shared Variables
puts "Closures and Shared Variables"
def accessor_pair(initialValue=nil)
    value = initialValue 
    getter = lambda { value }
    setter = lambda { |x| value = x }
    return getter, setter
end
  
getX, setX = accessor_pair(0) 
puts getX[] 
setX[10] 
puts getX[]


# Closures and Bindings
puts "Closures and Bindings"
def multiplier(n)
    lambda { |data| data.collect { |x| x * n } }
end
  
doubler = multiplier(2)
puts doubler.call([1, 2, 3])
eval("n=3", doubler.binding)
puts doubler.call([1, 2, 3])
  
# Unbound Method Objects
puts "Unbound Method Objects"
class Square
    def area
      @side * @side
    end
  
    def initialize(side)
      @side = side
    end
end
  
area_un = Square.instance_method(:area)
  
s = Square.new(12)
area = area_un.bind(s)
puts area.call   #=> 144
  

# Applying a Function to an Enumerable
puts "Applying a Function to an Enumerable"

# Composing Functions

