require 'socket'

host, port = ARGV

server = TCPSocket.open(host, port)

while line = server.gets
    puts line.chop
end
server.close