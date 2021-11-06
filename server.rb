# Libraries
require "socket"

# Modules
require "./Entities/Member.rb"
require "./Entities/Members.rb"

# Variables
PORT = 2000
members = Members.new

# Create server
server = TCPServer.new(PORT)
puts "Server running on port #{PORT}..."

# Server loop
while true

  # Set new socket connection on new thread
  tcp_socket = server.accept
  Thread.new(tcp_socket) do | socket|

  # Retrieve user and connection
  socket.print "Enter a username: "
  username = socket.gets.chomp
  new_member = Member.new(username, socket)

  # Store new user and wellcome
  members.add(new_member)
  new_member.welcome(members)
  members.broadcast("[joined]", new_member)

  end
end