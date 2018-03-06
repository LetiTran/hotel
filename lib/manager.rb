# # require_relative 'block'
# require_relative 'reservation'
# require_relative 'room'
# require 'Date'

module Hotel
  class Manager
    attr_reader :all_rooms, :all_reservations

    def initialize
      @all_rooms = initialize_all_rooms
      @all_reservations = Array.new()
    end

    def initialize_all_rooms
      all_rooms = []
      20.times {|i| all_rooms << Room.new(i + 1)}
      return all_rooms
    end

    def add_reservation(check_in, check_out)
      new_reservation_data =
      { reservation_id: (@all_reservations.length + 1),
        check_in: Date.parse(check_in),
        check_out: Date.parse(check_out),
        room: select_room(check_in, check_out)
      }
      created_reservation = Reservation.new(new_reservation_data)
      all_reservations << created_reservation
      return created_reservation
    end

    def select_room(check_in, check_out)
      all_rooms.each do |room|
        return room if room.room_reservations.empty?
        room.room_reservations.each {|reservation| return room if reservation.start_date != check_in && reservation.start_date != check_out}
    end

  end
end # Manager
end # Hotel
