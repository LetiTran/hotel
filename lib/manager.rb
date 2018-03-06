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
        return "#{message} "
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

    def available_rooms(date1, date2)
      available_rooms = []

      date_requested_range = (Date.parse(date1)..Date.parse(date2)).map{ |date| }
      date_requested_range.sort

      # all_rooms.each {|room| available_rooms << room if date_range.each{|date| room.room_reservations.start_date != date && (room.room_reservations.end_date - 1) != date}} if date2.nil?

      # if date2.nil?
      # puts "date_requested_range = #{date_requested_range}"


      all_rooms.each do |room|
        puts room
        puts room.room_reservations.length
        if room.room_reservations.empty?
          available_rooms << room
        else

          room.room_reservations.each do |reservation|
            # puts reservation
            #   puts "room = #{reservation.room}"
            #   puts "reserv = #{reservation}"
            #   puts "start_date = #{reservation.start_date}"
            start_date = reservation.start_date
            end_date = reservation.end_date
            #
            reservation_date_range = (start_date..end_date).map{ |date| }
            reservation_date_range.sort
            #   puts "reservation_date_range = #{reservation_date_range}"
            #
            #   available_rooms << room if reservation_date_range.include?(date_requested_range) == false
            date_requested_range.each do |date|
              # puts date

              reservation_date_range.each do |reserv_day|
                # puts reserv_day
                #
                if reserv_day != date
                  available_rooms << room
                  #
                end
              end
            end
          end
        end
      end
      # available_rooms.each {|room| puts room.id}
      return available_rooms.uniq

      # all_rooms.each {|room| available_rooms << room if room.room_reservations.start_date != date1 }

    end

    def list_reservations_at
    end

    def total_cost_of_reservation(reservation_id)
      this_reserv = all_reservations.find {|reserv| reserv.id == reservation_id}
      this_reserv.nil? ? ArgumentError : this_reserv.cost
    end
  end # Manager
end # Hotel
