# Libraries
require 'socket'

# Modules
require './Entities/Member'
require './Entities/Members'

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
  Thread.new(tcp_socket) do |socket|
    member = members.register(socket)
    members.listen_for_input(socket, member)
  rescue EOFError
    members.disconnect(socket, member)
  end
end
