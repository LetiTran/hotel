module Hotel
  class Room

    attr_reader :room_reservations , :status, :room_id

    def initialize(id)
      @room_id = id
      @room_reservations = [] #get_reservations_in_room == nil ? [] : get_reservations_in_room
      @status = available? ? :AVAILABLE  : :UNAVAILABLE
    end

    def available?
      true if @room_reservations.empty?
    end

    def get_reservations_in_room
      reservations = []
      Hotel::Manager.all_reservations.each do |reservation|
        reservations << reservation.room
        return reservations.uniq
      end
    end

  end
end
