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
      @manager.all_rooms[0].room_id.must_equal 1
      @manager.all_rooms[19].room_id.must_equal 20
    end

    it 'has collections of reservations' do
      @manager.must_respond_to :all_reservations
      @manager.all_reservations.must_be_kind_of Array
    end
  end #initialize

  describe '#add_reservation' do
    it 'creates a new reservation' do

    end

    it 'Selects an available room' do
    end

    it 'adds new reservation to all_reservations list' do

    end

  end


end # manager
