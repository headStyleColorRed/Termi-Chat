# Stores an array of members
class Members
  include Enumerable

  def initialize
    @members = []
  end

  def each(&block)
    @members.each(&block)
  end

  def register(socket)
    # Retrieve user and connection
    socket.print 'Enter a username: '
    username = socket.gets.chomp
    member = Member.new(username, socket)

    # Store new user and wellcome
    add(member)
    member.welcome(@members)
    broadcast('[joined]', member)

    member
  end

  def listen_for_input(socket, member)
    loop do
      message = socket.readline
      broadcast(message, member)
    end
  end

  def add(member)
    @members << member
  end

  def remove(member)
    @members.delete(member)
  end

  def broadcast(message, sender)
    receivers = @members - [sender]
    receivers.each do |receiver|
      receiver.socket.puts("> #{sender.username}: #{message}")
    end
  end

  def disconnect(socket, member)
    socket.close
    remove(member)
    broadcast('[left]', member)
  end
end
