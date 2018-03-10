require 'awesome_print'
module Hotel
  class Manager
    attr_reader :all_rooms, :all_reservations, :nigth_rate, :blocks

    def initialize
      @all_rooms = initialize_all_rooms
      @all_reservations = Array.new()
      @nigth_rate = 200
      @blocks = Array.new()
    end

    #______________Reports_for_management:

    def available_rooms(date1, date2)
      validate_date_input(date1, date2)

      available_rooms = all_rooms

      date_requested_range = get_date_range(date1, date2)

      date_requested_range.each do |date|
        available_rooms.each {|room| available_rooms.delete(room) if room.ocupied_on.include?(date)}
      end
      return available_rooms
    end

    def list_reservations_at(reuqested_date)
      validate_date_input(reuqested_date)

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

    def check_available_block_rooms(given_block_id)
      # Find desired block of rooms:
      block = find_block(given_block_id)
      # Returns list with available rooms or a message if there are no available rooms.
      no_rooms_message = "There are no available rooms"
      return block.available_rooms.empty? ? no_rooms_message : block.available_rooms
    end

    #______________Actions_for_management:

    def add_reservation(check_in, check_out, room = 0 )
      validate_date_input(check_in, check_out)

      # Parse date inputs:
      if check_in.class != Date
        check_in = parse_check_in(check_in)
        check_out = parse_check_out(check_out)
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

    def create_block(first_date, last_date, rooms, discount_rate)
      # Validade inputs:
      validate_discount_rate_input(discount_rate)
      validate_block_room_inputs(rooms)
      validate_date_input(first_date, last_date)

      # Get date range for this new block:
      block_dates = get_date_range(first_date, last_date)

      # Get rooms:
      block_rooms = []
      rooms.each {|id|  block_rooms <<  find_room(id)}


      # Organize new block info:
      block_data = {id: @blocks.length + 1, date_range: block_dates, rooms: block_rooms, discount_rate: discount_rate}
      # Create new block:
      new_block = Block.new(block_data)
      blocks << Block.new(block_data)

      return new_block
    end

    def reserve_room_in_block(block_id, room: 1)
      block = find_block(block_id)
      room = find_room(room)
      new_reservation = add_reservation(block.date_range[0], block.date_range.last, room)

      @blocks << new_reservation

      return new_reservation
    end


    #______________Private_methods:
    private

    def initialize_all_rooms
      all_rooms = []
      20.times {|i| all_rooms << Room.new(i + 1)}
      return all_rooms
    end

    def parse_check_in(check_in)
      return check_in = Date.parse(check_in)
    end

    def parse_check_out(check_out)
      return check_out = Date.parse(check_out)
    end

    def validate_date_input(first_date, last_date = "")
      # Parse inputs
      if first_date.class == String
        begin
          first_date = parse_check_in(first_date)
          last_date = parse_check_out(last_date)
        rescue
          ArgumentError.new("Please enter start and end date for new block of rooms.")
        end
      end
      # Start date is >= Today:
      raise ArgumentError.new("#{first_date} has already passed.") if first_date < Date.today

      # Start date is < end date:
      raise ArgumentError.new("#{first_date} has already passed.") if first_date > last_date if last_date.class != String
    end

    def get_date_range(date1, date2)
      return (Date.parse(date1)..Date.parse(date2)).map{|date| date}
    end

    def select_room_for_new_reserv(check_in, check_out)
      return available_rooms(check_in, check_out)[0]
    end

    def find_room(room_id)
      return @all_rooms.find{ |room| room.id == room_id }
    end

    def find_block(block_id)
      # Find desired block of rooms:
      block = @blocks.find {|block| block.id == block_id}
      # Check if block exists:
      raise ArgumentError.new("Block #{block} does not exist.") if block == nil

      return block
    end
    def room_available?(check_in, check_out, room)
      # range_date = get_date_range(date1, date2)
      available = available_rooms(check_in, check_out).include?(room) ? true : false
      return available
    end

    def validate_block_room_inputs(rooms)
      # Input is array with rooms ids:
      raise ArgumentError.new("#{rooms} is not a vlaid input. Input must be an array of room id's.") if rooms.class != Array || rooms[0].class != Integer || rooms.each {|i| find_room(rooms[i])} == nil
    end

    def validate_discount_rate_input(discount_rate)
      raise ArgumentError.new("#{discount_rate} is not a valid rate. Discount rate must be a number.") if discount_rate.class != Float && discount_rate.class != Integer
      raise ArgumentError.new("#{discount_rate} must be a positive number.") if  discount_rate < 0
    end
  end # Manager
end # Hotel
