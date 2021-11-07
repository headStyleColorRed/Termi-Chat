# Stores an array of members
class Members
  include Enumerable

  def initialize
    @members = []
  end

  def each(&block)
    @members.each(&block)
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
end
