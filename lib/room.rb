module Hotel
  class Room

    attr_reader :reservations , :status, :room_id

    def initialize
      @room_id = 1
      @reservations = [] #get_reservations_in_room == nil ? [] : get_reservations_in_room
      @status = available?
    end

    def available?
      true if @reservations.empty?
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
