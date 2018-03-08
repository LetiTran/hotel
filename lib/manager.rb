# # require_relative 'block'
require_relative 'reservation'
require_relative 'room'
require 'Date'
require 'awesome_print'

module Hotel
  class Manager
    attr_reader :all_rooms, :all_reservations, :nigth_rate

    def initialize
      @all_rooms = initialize_all_rooms
      @all_reservations = Array.new()
      @nigth_rate = 200
    end

    def add_reservation(check_in, check_out)

      # Evaluate inputs
      begin
        check_in = Date.parse(check_in)
        check_out = Date.parse(check_out)
      rescue ArgumentError => message
        return "#{message} "
      end

      # Creat new reservation:
      new_reservation_data =
      { reservation_id: (@all_reservations.length + 1),
        check_in: check_in,
        check_out: check_out,
        room: available_rooms(check_in.to_s, check_out.to_s)[0],
        # room: select_room_for_new_reserv(check_in, check_out),
        nigth_rate: nigth_rate
      }
      created_reservation = Reservation.new(new_reservation_data)

      # Add reservation to all_reservations list
      all_reservations << created_reservation
      # puts "file all reserv length = #{all_reservations.length}"
      # puts "file all reserv 0 = #{all_reservations[0]}"
      # puts "file all reserv 1 = #{all_reservations[1]}"
      # puts "file room1 0 = #{all_reservations[0].room}"
      # Add date range of reservation to the room list:
      reservation_ocupie_room = (check_in...check_out).map{|date| date}
      # puts "reservation_ocupie_room dates = #{reservation_ocupie_room}"

      reservation_ocupie_room.each {|date| created_reservation.room.ocupied_on << date}
      # puts "room.ocupied_on = #{created_reservation.room.ocupied_on}"
      #  ocupied_on was room_reservations


      # Return new reservation:
      return created_reservation
    end

    def available_rooms(date1, date2)
      available_rooms = all_rooms
      date_requested_range = (Date.parse(date1)..Date.parse(date2)).map{|date| date}

      date_requested_range.each do |date|
        available_rooms.each do |room|
          if room.ocupied_on.include?(date)
            available_rooms.delete(room)
          end
        end
      end
      return available_rooms
    end

    def list_reservations_at(reuqested_date)
      date_reservations = []

      all_reservations.each do |reservation|
        start_date = reservation.start_date
        end_date = reservation.end_date

        reservation_date_range = (start_date..end_date).map{ |date| date}

        date_reservations << reservation if reservation_date_range.include?(Date.parse(reuqested_date))
        return date_reservations
      end
    end

    def total_cost_of_reservation(reservation_id)
      this_reserv = all_reservations.find {|reserv| reserv.id == reservation_id}
      this_reserv.nil? ? ArgumentError : this_reserv.cost
    end

    private

    def initialize_all_rooms
      all_rooms = []
      20.times {|i| all_rooms << Room.new(i + 1)}
      return all_rooms
    end

    def select_room_for_new_reserv(check_in, check_out)
      # return available_rooms(check_in, check_out)[0]
      date_requested_range = (check_in..check_out).map{ |date| date}
      # puts "puts all_rooms = #{all_rooms}"

      all_rooms.each do |room|
        if room_available?(date_requested_range, room) == true
          return room
        end
      end
      #   return room if room.ocupied_on.empty?
      #
      #   room.ocupied_on.each {|reservation| return room if !((reservation.start_date...reservation.end_date).map{ |date| date}.include?(date_requested_range))}
      #
      #   #if room_available?(date_requested_range, room)}
      # end
      # puts "no available rooms"
    end

    # def rooms_available(date_requested_range, room)
    #   available_rooms = []
    #   available_rooms << room if room_available?(date_requested_range, room) == true
    #   return available_rooms
    # end

    def room_available?(date_requested_range, room)
      #############
      # change to:

      # date_requested_range.each do |date|
      #   room.each do |r|
      #     if r.ocupied_on.include?(date)
      #       return true
      #     end
      #   end
      # end
      ##############

      room.ocupied_on.include?(date_requested_range) ?  false : true

      # puts "map"
      # puts (reservation.start_date...reservation.end_date).map{ |date| date}
      # reservation_date_range = (reservation.start_date...reservation.end_date).map{ |date| date}
      # return false if reservation_date_range.include?(date_requested_range)
      # end
    end

  end # Manager
end # Hotel


puts "-------------------------------------------------------"
puts "\n"
manager = Hotel::Manager.new


# # Add a reservation:
# new_reserv = manager.add_reservation('3rd Feb 2020','5 Feb 2020')
# puts "new_reserv = #{new_reserv}"
# puts "new_reserv.id = #{new_reserv.id}"
# ap "manager.all_reservations = #{manager.all_reservations[0].id}"
# # puts "manager.all_reservations = #{manager.all_reservations.each {|i| i.id }}"
# puts "\n"
# check_date_03_to_5 = manager.available_rooms('3rd Feb 2020', '5 Feb 2020' )
#
# # Assert:
# ap check_date_03_to_5
# puts "lenght = #{check_date_03_to_5.length}"
# puts "\n"
#
# ap "Add another reservation:"
# new_reserv2 = manager.add_reservation('3rd Feb 2020','5 Feb 2020')
# puts "new_reserv2 = #{new_reserv2}"
# puts "new_reserv2.id = #{new_reserv2.id}"
# ap "manager.all_reservations = #{manager.all_reservations[1].id}"
# # puts "manager.all_reservations = #{manager.all_reservations.each {|i| i.id}}"
# puts "\n"
# check_date_03_to_5 = manager.available_rooms('3rd Feb 2020', '5 Feb 2020' )
# puts "\n"
# # Assert:
# ap check_date_03_to_5
# puts "lenght = #{check_date_03_to_5.length}"
# puts "\n"
#
# ap "Add another reservation:"
# new_reserv2 = manager.add_reservation('3rd Feb 2020','5 Feb 2020')
# puts "new_reserv2 = #{new_reserv2}"
# puts "new_reserv2.id = #{new_reserv2.id}"
# ap "manager.all_reservations = #{manager.all_reservations[1].id}"
# # puts "manager.all_reservations = #{manager.all_reservations.each {|i| i.id}}"
# puts "\n"
# check_date_03_to_5 = manager.available_rooms('3rd Feb 2020', '5 Feb 2020' )
# puts "\n"
# # Assert:
# ap check_date_03_to_5
# puts "lenght = #{check_date_03_to_5.length}"
# puts "\n"
# puts "-------------------------------------------------------"
