# Stores an only readable username and his socket connection

class Member
  attr_reader :username, :socket

  # Initialitation
  def initialize(username, socket)
    @username = username
    @socket = socket
  end

  # Welcoming response on first load
  def welcome(members)
    socket.puts "Welcome, #{username}! There are #{members.count} people here"
  end
end
