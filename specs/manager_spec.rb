require_relative 'spec_helper'
require 'awesome_print'
describe 'Manager' do
  describe '#initialize' do
    before do
      @manager = Hotel::Manager.new
      @room = Hotel::Room.new(1)
    end
    it "can be created" do
      @manager.must_be_kind_of Hotel::Manager
    end

    it 'has collections of rooms' do
      @manager.must_respond_to :all_rooms
      @manager.all_rooms.must_be_kind_of Array
      @manager.all_rooms[0].id.must_equal 1
      @manager.all_rooms[19].id.must_equal 20
    end

    it 'has collections of reservations' do
      @manager.must_respond_to :all_reservations
      @manager.all_reservations.must_be_kind_of Array
      @manager.all_reservations.length.must_equal 0
    end

    it 'has a collection of blocks' do
      @manager.must_respond_to :blocks
      @manager.blocks.must_be_kind_of Array
      @manager.blocks.length.must_equal 0
    end
  end #initialize

  describe '#add_reservation' do
    before do
      @manager = Hotel::Manager.new
      @new_reservation = @manager.add_reservation('3rd Feb 2020','5 Feb 2020')
    end
    it 'creates a new reservation' do
      @new_reservation.must_be_instance_of Hotel::Reservation
      @new_reservation.id.must_be_kind_of Integer
      @new_reservation.cost.must_be_kind_of Integer
    end

    it 'Selects an available room' do
      @new_reservation.room.must_be_instance_of Hotel::Room
      @new_reservation.room.id.must_be_kind_of Integer
    end

    it 'adds the new reservation to all_reservations list' do
      @manager.all_reservations.length.must_equal 1
      @manager.all_reservations[0].must_equal @new_reservation
    end

    it 'adds the new reservation to the room list' do
      @new_reservation.room.ocupied_on.length.must_be :>, 0
      @new_reservation.room.ocupied_on[0].must_be_kind_of Date
    end

    it 'Raises an error if not possible to add input as a Date' do

      proc {@manager.add_reservation('3rd Feb 2020','a').must_raise ArgumentError}
    end

    it 'Creates a reservation to a room that will have a checkout on same day' do
      19.times {@manager.add_reservation('3rd Feb 2020','5 Feb 2020')}

      @manager.add_reservation('5 Feb 2020','6 Feb 2020')

      @manager.all_reservations.length.must_equal 21

    end

  end

  describe '#total_cost_of_reservation' do
    before do
      @manager = Hotel::Manager.new
      @manager.add_reservation('3rd Feb 2020','5 Feb 2020') #reservation id = 1
      @manager.add_reservation('10 Feb 2019','15 Feb 2019') #reservatio id =  2
      @manager.add_reservation('22 Mar 2018','23 Mar 2018') #reservatio id =  3
    end

    it 'Finds a specific reservation' do
      # reservation_id = 1
      # manager.total_cost_of_reservation(reservation_id).must_equal
    end

    it 'Calculates the total cost of a specific reservation' do
      reservation_id = 1
      @manager.total_cost_of_reservation(reservation_id).must_equal 400

      reservation_id = 3
      @manager.total_cost_of_reservation(reservation_id).must_equal 200

      reservation_id = 2
      @manager.total_cost_of_reservation(reservation_id).must_equal 1000

      # Create a block and new reservation on it:
      @new_block = @manager.create_block('3rd Feb 2020','5 Feb 2020', [8,9,10], 150)
      @new_block_room_reservation = @manager.reserve_room_in_block(1, room: 10) #reservatio id =  4
      # Assert:
      @manager.total_cost_of_reservation(4).must_equal 150*2
    end

    it 'Returns an error if reservation do not exists' do
      proc {@manager.total_cost_of_reservation(10).must_raise ArgumentError}
    end


  end

  describe '#available_rooms' do
    it 'returns a list of available rooms' do
      @manager = Hotel::Manager.new

      # Add a reservation:
      new_reserv = @manager.add_reservation('3rd Feb 2020','5 Feb 2020')
      # Assert:
      @manager.available_rooms('3rd Feb 2020', '5 Feb 2020' ).must_be_kind_of Array
      @manager.available_rooms('3rd Feb 2020', '5 Feb 2020' )[0].must_be_kind_of Hotel::Room
      @manager.available_rooms('3rd Feb 2020', '5 Feb 2020').length.must_equal 19
      @manager.available_rooms('3rd Feb 2020', '5 Feb 2020')[0].id.must_equal 2

      # Add one more reservation:
      now = @manager.add_reservation('3rd Feb 2020','5 Feb 2020')
      # # Assert:
      @manager.available_rooms('3rd Feb 2020', '5 Feb 2020' ).must_be_kind_of Array
      @manager.available_rooms('3rd Feb 2020', '5 Feb 2020').length.must_equal 18

      # Create a block and new reservation on it:
      @new_block = @manager.create_block('3rd Feb 2020','5 Feb 2020', [8,9,10], 150)
      @new_block_room_reservation = @manager.reserve_room_in_block(1, room: 10)
      # Assert:
      @manager.available_rooms('3rd Feb 2020', '5 Feb 2020').length.must_equal 17
    end
  end

  describe "#list_reservations_at" do
    it 'returns a list with reservations for that day' do
      @manager = Hotel::Manager.new

      # Add a reservation:
      @manager.add_reservation('3rd Feb 2020','5 Feb 2020')
      # Assert:
      @manager.list_reservations_at('3rd Feb 2020').must_be_kind_of Array
      @manager.list_reservations_at('3rd Feb 2020').length.must_equal 1

      # Create a block and new reservation on it:
      @new_block = @manager.create_block('3rd Feb 2020','5 Feb 2020', [2,3,4], 150)
      @new_block_room_reservation = @manager.reserve_room_in_block(1, room: 2)
      # Assert:
      @manager.list_reservations_at('3rd Feb 2020').length.must_equal 2
    end
  end

  describe '#reserve_room' do

    before do
      @manager = Hotel::Manager.new
      @new_reservation = @manager.reserve_room('3rd Feb 2020','5 Feb 2020', 20)
    end

    it 'creates a new reservation' do
      @new_reservation.must_be_instance_of Hotel::Reservation
      @new_reservation.id.must_be_kind_of Integer
      @new_reservation.cost.must_be_kind_of Integer
    end

    it 'reserves a specific room' do
      @new_reservation.room.id.must_equal 20
      @new_reservation.room.must_be_instance_of Hotel::Room
      @new_reservation.room.id.must_be_kind_of Integer
    end

    it 'throw an error if room is not available' do
      proc {@manager.reserve_room('3rd Feb 2020','5 Feb 2020', 20)}.must_raise StandardError
    end

    it 'Throws an error if room does not exits' do
      proc {@manager.reserve_room('3rd Feb 2020','5 Feb 2020', 30)}.must_raise ArgumentError
    end

    it 'throws an error if room is set aside for a block' do
      # Create a block and new reservation on it:
      new_block = @manager.create_block('3rd Feb 2020','5 Feb 2020', [2,3,4], 150)
      # Assert:
      proc {@manager.reserve_room('3rd Feb 2020','5 Feb 2020', 2)}.must_raise StandardError
    end

  end

  describe '#create_block' do
    before do
      @manager = Hotel::Manager.new
      @new_block = @manager.create_block('3rd Feb 2020','5 Feb 2020', [1,2,3], 150)
    end

    it 'Initializes a block ' do

      @new_block.must_be_kind_of Hotel::Block
      @manager.blocks[0].id.must_equal @new_block.id
    end

    it 'Checks for a valid range date' do
      # (uses evaluate_date_input private method)
      # Start date is >= Today:
      proc {@manager.create_block('3 Feb 2017','5 Feb 2020', [1,2,3], 150)}.must_raise ArgumentError

      # Start date is < end date:
      proc {@manager.create_block('5 Feb 2017','3 Feb 2020', [1,2,3], 150)}.must_raise ArgumentError

      # Has start date & end date:
      proc {@manager.create_block('5 Feb 2020', [1,2,3], 150)}.must_raise ArgumentError
    end

    it 'Raises argument error for invalid room inputs' do
      # (uses evaluate_block_room_inputs private method)
      # Input is room ids array:
      proc {@manager.create_block('3rd Feb 2020','5 Feb 2020', %w[a,b,c], 150)}.must_raise ArgumentError

      # All rooms desired are available:
      @manager.reserve_room('3rd Feb 2020','5 Feb 2020', 4)
      proc {@manager.create_block('3rd Feb 2020','5 Feb 2020', [4,2,3], 150)}.must_raise StandardError

      #Max_rooms = 5 and Min_rooms = 2 tested in block_spec.rb
    end

    it 'Raises argument error for invalid discount rate inputs' do
      # (validate_discount_rate_input)
      # Rate input must be a number:
      proc {@manager.create_block('3rd Feb 2020','5 Feb 2020', [1,2,3], "string")}.must_raise ArgumentError
      # Rate input must be > 0:
      proc {@manager.create_block('3rd Feb 2020','5 Feb 2020', [1,2,3], -1)}.must_raise ArgumentError
    end

    #TODO
    it 'Checks that initializes with available rooms only for that date range' do
      assert = []
      @new_block.rooms.each {|room| assert << room.ocupied_on.empty?}
      assert.each { |i| i.must_equal TRUE }
    end

    #TODO
    it 'the room set aside for a block should not be available for other types of reservations' do
      proc {@manager.reserve_room('3rd Feb 2020','5 Feb 2020', 2)}.must_raise StandardError
    end
  end

  describe '#check_available_block_rooms' do

    before do
      @manager = Hotel::Manager.new
      @new_block = @manager.create_block('3rd Feb 2020','5 Feb 2020', [1,2,3], 150)
    end

    it 'Throws an error if room doesnt exits' do
      proc {@manager.check_available_block_rooms(100)}.must_raise ArgumentError
    end

    it 'returns available rooms in the block' do
      @manager.check_available_block_rooms(1).must_be_kind_of Array
      @manager.check_available_block_rooms(1).length.must_equal 3
      @manager.check_available_block_rooms(1)[0].must_be_kind_of Hotel::Room
    end

    it 'returnes a message if there are no available rooms' do
      @manager.reserve_room_in_block(1, room: 1)
      @manager.reserve_room_in_block(1, room: 2)
      @manager.reserve_room_in_block(1, room: 3)
      # Assert:
      @manager.check_available_block_rooms(1).must_be_kind_of String
      @manager.check_available_block_rooms(1).must_equal "There are no available rooms"
    end
  end

  describe '#reserve_room_in_block' do
    before do
      @manager = Hotel::Manager.new
      @new_block = @manager.create_block('3rd Feb 2020','5 Feb 2020', [1,2,3], 150)
      @new_block_room_reservation = @manager.reserve_room_in_block(1, room: 2)
    end

    it 'checks if requested room belongs to the requested block' do
      proc {@manager.reserve_room_in_block(1, room: 8)}.must_raise ArgumentError
    end

    it 'reservers a room from a specific block' do
      @new_block_room_reservation.must_be_kind_of Hotel::Reservation

      # Creates reservation:
      @manager.all_reservations[0].must_equal @new_block_room_reservation
      @manager.all_reservations[0].room.id.must_equal 2
      @manager.all_reservations[0].id.must_equal @new_block_room_reservation.id

      # Assert that reservation has a block:
      @manager.all_reservations[0].block.must_be_kind_of Hotel::Block
      @manager.all_reservations[0].block.id.must_equal 1
    end

    it 'accepts input of specific room as not required' do
      reserve_random_room_in_block = @manager.reserve_room_in_block(1)
      reserve_random_room_in_block.must_be_kind_of Hotel::Reservation
      @manager.all_reservations[1].id.must_equal reserve_random_room_in_block.id
    end

    it 'has matching dates for both reservation and block' do
      @new_block_room_reservation.start_date.must_equal @new_block_room_reservation.block.date_range.first
      # Assert:
      @new_block_room_reservation.end_date.must_equal @new_block_room_reservation.block.date_range.last
    end

    it 'sets room as unvailable for other types of reservations for that date' do
      room_id = @new_block_room_reservation.room.id
      # Assert:
      proc {@manager.reserve_room('3rd Feb 2020','5 Feb 2020', room_id)}.must_raise StandardError
    end
  end
end # Manager
