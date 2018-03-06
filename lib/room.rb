# require_relative 'reservation'
# require_relative 'manager'

module Hotel
  class Room

    attr_reader :room_reservations, :id

    def initialize(id)
      @id = id
      @room_reservations = []
    end

  end
end
