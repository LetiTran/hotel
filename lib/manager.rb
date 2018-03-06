# require_relative 'block'
require_relative 'reservation'
require_relative 'room'

module Hotel
  class Manager
    attr_reader :all_rooms, :all_reservations

    def initialize
      @all_rooms = initialize_all_rooms
      @all_reservations = []
      @room_rate = 200
    end

    def initialize_all_rooms
      all_rooms = []
      20.times {|i| all_rooms << Hotel::Room.new(i + 1)}
      return all_rooms
    end

    def add_reservation
      reservation = Reservation.new(checkin, checkout, select_room, room_rate)
      all_reservations << reservation
    end

    def select_room

      # status = available? ? :AVAILABLE  : :UNAVAILABLE

      # def available?
      #   true if @room_reservations.empty?
      #   #CHANGE THIS TO CHECK DATE
      # end

      # all_rooms.each {|room| return room if room.status == :AVAILABLE}
      1

    end

  end
end

#
# puts manager = Hotel::Manager.new
# puts "all = #{manager.all_reservations}"
