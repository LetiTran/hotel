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

  end
end # Manager
