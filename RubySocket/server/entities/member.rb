# Stores an only readable userId, roomid and his socket connection

class Member
  attr_reader :user_id, :socket, :room_id

  # Initialitation
  def initialize(user_id, socket, room_id)
    @user_id = user_id
    @socket = socket
    @room_id = room_id
  end
end
