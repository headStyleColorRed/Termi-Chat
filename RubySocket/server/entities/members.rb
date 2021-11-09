# Stores an array of members
class Members
  include Enumerable

  def initialize
    @members = []
  end

  # Retrieve user and connection and add it to members array
  def register(user_id, socket, room_id)
    member = Member.new(user_id, socket, room_id)
    @members << member
  end

  def broadcast(message)
    # Decode message and get room id and user id
    decoded_message = JSON.parse(message)
    room_id = decoded_message['chatroom']
    user_id = decoded_message['sender']['id']

    # Get all users in this room
    room_users = @members.select { |member| member.room_id == room_id }

    # Get sender user to leave him out of the broadcast
    receivers = room_users.reject { |member| member.user_id == user_id }

    # Send message to the rest of users in room
    receivers.each do |receiver|
      receiver.socket.send(message)
    end
  end

  def disconnect(socket)
    member_to_delete = nil

    # Search for member with that websocket
    @members.each do |member|
      member_to_delete = member if member.socket == socket
    end

    return if member_to_delete.nil?

    @members.delete(member_to_delete)
  end
end
