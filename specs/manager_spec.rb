require_relative 'spec_helper'

describe 'Manager' do
  describe 'initialize' do
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
      @new_reservation.room.room_reservations.length.must_equal 1
      @new_reservation.room.room_reservations[0].must_equal @new_reservation
    end

  end

  describe 'total_cost_of_reservation' do
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
    end

    it 'Returns an error if reservation do not exists' do
    proc {@manager.total_cost_of_reservation(10).must_raise ArgumentError}
    end


  end
end # Manager
