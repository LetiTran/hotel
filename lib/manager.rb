# # require_relative 'block'
# require_relative 'reservation'
require_relative 'room'
# require 'Date'

module Hotel
  class Manager
    attr_reader :all_rooms, :all_reservations, :nigth_rate

    def initialize
      @all_rooms = initialize_all_rooms
      @all_reservations = Array.new()
      @nigth_rate = 200
    end

    def initialize_all_rooms
      all_rooms = []
      20.times {|i| all_rooms << Room.new(i + 1)}
      return all_rooms
    end

    def add_reservation(check_in, check_out)
      # Creat new reservation:
      begin
        check_in = Date.parse(check_in)
        check_out = Date.parse(check_out)
      rescue ArgumentError => message
        puts "#{message} is not a date"
      end
        new_reservation_data =
        { reservation_id: (@all_reservations.length + 1),
          check_in: check_in,
          check_out: check_out,
          room: select_room(check_in, check_out),
          nigth_rate: nigth_rate
        }

      created_reservation = Reservation.new(new_reservation_data)

      # Add reservation to all_reservations list
      all_reservations << created_reservation

      # Add reservation to the room list:
      (new_reservation_data[:room]).room_reservations << created_reservation
      # Return new reservation:
      return created_reservation
    end

    def select_room(check_in, check_out)
      all_rooms.each do |room|
        return room if room.room_reservations.empty?
        room.room_reservations.each {|reservation| return room if reservation.start_date != check_in && reservation.start_date != check_out} #add more conditional here for the mid of the dates
      end

    end

    # def list_all_rooms
    #   return all_rooms
    # end

    def list_reservations_at(date)

    end

    def total_cost_of_reservation(reservation_id)
      this_reserv = all_reservations.find {|reserv| reserv.id == reservation_id}
      this_reserv.nil? ? ArgumentError : this_reserv.cost
    end
  end # Manager
end # Hotel
