# require_relative 'reservation'
# require_relative 'manager'

module Hotel
  class Room

    attr_accessor :nigth_rate, :id, :room_reservations

    def initialize(id)
      @id = id
      @nigth_rate = 200
      @room_reservations = []
    end
  end
end
