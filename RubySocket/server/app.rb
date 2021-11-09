# Libraries
require 'em-websocket'
require 'json'

# Modules
require './Entities/Member'
require './Entities/Members'

# Members
PORT = 2000
members = Members.new

# Create server
puts "Server running on port #{PORT}..."

EventMachine.run do
  EventMachine::WebSocket.run(host: '0.0.0.0', port: PORT, debug: false) do |socket|
    socket.onopen do |handshake|
      puts 'Received new connection'

      # Register new user
      user_id = handshake.query['userId']
      room_id = handshake.path.delete_prefix('/')
      members.register(user_id, socket, room_id)
      puts "Register user with id #{user_id} at room #{room_id}"

      socket.send 'Handshake Confirmation'
    end

    socket.onmessage do |message|
      members.broadcast(message)
    end

    socket.onclose do
      puts 'WebSocket closed'
      members.disconnect(socket)
    end

    socket.onerror do |error|
      puts "Error: #{error.message}"
    end
  end
end
