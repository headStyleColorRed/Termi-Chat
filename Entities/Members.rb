# Stores an array of members
class Members
  include Enumerable

  def initialize
    @members = []
  end

  def each
    @members.each { |member| yield member }
  end

  def add(member)
    @members << member
  end

  def remove(member)
    @members.delete(member)
  end
end