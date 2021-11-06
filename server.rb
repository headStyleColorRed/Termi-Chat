require "socket"

# Variables
PORT = 2000

# Create server

server = TCPServer.new(PORT)
puts "Server running on port #{PORT}"

while true
  connection = server.accept

  # Retrieve user name
  connection.print "What's your name? "
  name = connection.gets.chomp

  connection.puts "Welcome #{name}"
  connection.close

end