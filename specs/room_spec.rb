require_relative 'spec_helper'

describe 'Room' do
  describe 'initialize' do
    before do
      @manager = Hotel::Manager.new
      @room = Hotel::Room.new(1)
    end
    it "can be created" do
      @room.must_be_kind_of Hotel::Room
    end

    it 'has an id' do
      @room.must_respond_to :room_id
      @room.room_id.must_be_kind_of Integer
    end

    # it 'has a status' do
    #   @room.must_respond_to :status
    #   @room.status.must_be_kind_of Symbol
    #   # @room.status.must_be_kind_of FalseClass
    # end

    it 'has reservations' do
      @room.must_respond_to :room_reservations
      @room.room_reservations.must_be_kind_of Array
      # @room.room_reservations[0].must_be_kind_of Hotel::Reservation
       #Hotel::Room.new ||
    end
  end #initialize


end # room
