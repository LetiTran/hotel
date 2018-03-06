# require_relative 'reservation'
# require_relative 'manager'

module Hotel
  class Room

    attr_reader :room_reservations, :room_id #:status,

    def initialize(id)
      @room_id = id
      @room_reservations = [] #get_reservations_in_room == nil ? [] : get_reservations_in_room
      # @status = available? ? :AVAILABLE  : :UNAVAILABLE
    end

    # def available?
    #   true if @room_reservations.empty?
    #   #CHANGE THIS TO CHECK DATE
    # end

    def get_reservations_in_room
      reservations = []
      Manager.all_reservations.each do |reservation|
        reservations << reservation.room
      end
      return reservations.uniq
    end

    # def get_reservations_in_room
    #   Hotel::Manager.all_reservations.map{|reserv| reserv.room_id == room_id}
    # end

  end
end

# puts manager = Hotel::Manager.new
# puts manager.all_reservations
# puts Hotel::Manager.all_reservations
