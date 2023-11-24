require 'socket'
host = "localhost"
port = 2000
ds = UDPSocket.new
ds.connect(host, port) 

request = gets


ds.send(request.chomp, 0)
response,address = ds.recvfrom(1024) 
puts response