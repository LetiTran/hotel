# # require_relative 'block'
# require_relative 'reservation'
# require_relative 'room'

module Hotel
  class Manager
    attr_reader :all_rooms, :all_reservations

    def initialize
      @all_rooms = initialize_all_rooms
      @all_reservations = []
    end

    def initialize_all_rooms
      all_rooms = []
      20.times {|i| all_rooms << Room.new(i + 1)}
      return all_rooms
    end

    def add_reservation(check_in, check_out)
      new_reservation_data =
      { reservation_id: (@all_reservations.length + 1),
        check_in: Date.parse(check_in) ,
        check_out: Date.parse(check_out),
        room: select_room(check_in, check_out)
      }
      created_reservation = Reservation.new(new_reservation_data)
      all_reservations << created_reservation
      return created_reservation
    end

    def select_room(check_in, check_out)

      all_rooms.each do |room|
        if room.room_reservations.empty?
          return room
        else
          room.room_reservations.each do |reservation|
            if reservation.start_date != check_in && reservation.start_date != check_out
              return room
            end
          end
        end
      end

      # status = available? ? :AVAILABLE  : :UNAVAILABLE
      # def available?
      #   true if @room_reservations.empty?
      #   #CHANGE THIS TO CHECK DATE
      # end
      # all_rooms.each {|room| return room if room.status == :AVAILABLE}
      # return 1

    end

  end # Manager
end # Hotel

#
# puts manager = Hotel::Manager.new
# puts "all = #{manager.all_reservations}"
