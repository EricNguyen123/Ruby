require 'socket'
port = ARGV[0]
ds = UDPSocket.new 
ds.bind(nil, port) 
loop do
    request,address=ds.recvfrom(1024) 
    a = request.split(' ').map do |x| 
        x.to_i
    end
    response = a[0] + a[1]
    clientaddr = address[3] 
    clientname = address[2] 
    clientport = address[1] 
    ds.send(response.to_s, 0, clientaddr, clientport)
    puts "Connection from: #{clientname} #{clientaddr} #{clientport}" 
end