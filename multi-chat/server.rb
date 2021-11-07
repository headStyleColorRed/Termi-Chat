# Libraries
require 'socket'

# Modules
require './entities/member'
require './entities/members'

# Variables
PORT = 2000
members = Members.new

# Create server
server = TCPServer.new(PORT)
puts "Server running on port #{PORT}..."

# Server loop
loop do
  # Set new socket connection on new thread
  tcp_socket = server.accept
  # Create new thread
  Thread.new(tcp_socket) do |socket|
    member = members.register(socket)
    members.listen_for_input(socket, member)
  rescue EOFError
    members.disconnect(socket, member)
  end
end