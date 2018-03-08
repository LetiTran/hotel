module Hotel
  class Manager
    attr_reader :all_rooms, :all_reservations, :nigth_rate, :blocks

    def initialize
      @all_rooms = initialize_all_rooms
      @all_reservations = Array.new()
      @nigth_rate = 200
      @blocks = Array.new()
    end

    def add_reservation(check_in, check_out, room = 0 )
      evaluate_date_input(check_in, check_out)

      #fix this, no need for it.
      # Evaluate inputs
      begin
        check_in = Date.parse(check_in)
        check_out = Date.parse(check_out)
      rescue ArgumentError => message
        return "#{message} "
      end

      if room == 0
        room = select_room_for_new_reserv(check_in.to_s, check_out.to_s)
      end

      # Creat new reservation:
      new_reservation_data =
      { reservation_id: (@all_reservations.length + 1),
        check_in: check_in,
        check_out: check_out,
        room: room,
        # room: select_room_for_new_reserv(check_in, check_out),
        nigth_rate: nigth_rate
      }
      created_reservation = Reservation.new(new_reservation_data)

      # Add reservation to all_reservations list
      all_reservations << created_reservation

      # Add date range of reservation to the room list:
      reservation_ocupie_room = (check_in...check_out).map{|date| date}
      reservation_ocupie_room.each {|date| created_reservation.room.ocupied_on << date}

      # Return new reservation:
      return created_reservation
    end

    def available_rooms(date1, date2)
      evaluate_date_input(date1, date2)

      available_rooms = all_rooms

      date_requested_range = get_date_range(date1, date2)

      date_requested_range.each do |date|
        available_rooms.each {|room| available_rooms.delete(room) if room.ocupied_on.include?(date)}
      end
      return available_rooms
    end

    def reserve_room(check_in, check_out, room_id)
      # Find room with given id
      room = find_room(room_id)
      # Check if room esxists:
      raise ArgumentError.new("Room is does not exists") if all_rooms.include?(room) == false
      # Check if room is availble:
      raise StandardError.new("Room is not available") if room_available?(check_in, check_out, room) == false
      # Create reservation:
      add_reservation(check_in, check_out, room)
    end

    def list_reservations_at(reuqested_date)
      evaluate_date_input(reuqested_date)

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

    # def create_block(first_date, last_date, rooms, discount_rate)
    #   get_date_range(first_date, last_date)
    #
    #   block_data = {
    # date_range: date_range,
    #     rooms: rooms,
    #     discount_rate: discount_rate}
    #
    #     blocks << Block.new(block_data)
    #
    #   end

    private

    def evaluate_date_input(check_in, check_out = "")

      # Evaluate inputs
      begin
        check_in = Date.parse(check_in)
        check_out = Date.parse(check_out)
      rescue ArgumentError => message
        return "#{message} "
      end

    end

    def get_date_range(date1, date2)
      return (Date.parse(date1)..Date.parse(date2)).map{|date| date}

      # return (date1..date2).map{|date| date}
    end

    def initialize_all_rooms
      all_rooms = []
      20.times {|i| all_rooms << Room.new(i + 1)}
      return all_rooms
    end

    def select_room_for_new_reserv(check_in, check_out)
      return available_rooms(check_in, check_out)[0]
    end

    def room_available?(check_in, check_out, room)
      # range_date = get_date_range(date1, date2)
      available = available_rooms(check_in, check_out).include?(room) ? true : false
      return available
    end

    def find_room(room_id)
      return @all_rooms.find{ |room| room.id == room_id }
    end

  end # Manager
end # Hotel
