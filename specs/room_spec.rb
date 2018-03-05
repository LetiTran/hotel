require_relative 'spec_helper'

describe 'Room' do
  describe 'initialize' do
    before do
      @manager = Hotel::Manager.new
      @room = Hotel::Room.new
    end
    it "can be created" do
      @room.must_be_kind_of Hotel::Room
    end

    it 'has an id' do
      @room.must_respond_to :room_id
      @room.room_id.must_be_kind_of Integer
    end

    it 'has a status' do
      @room.must_respond_to :status
      @room.status.must_be_kind_of TrueClass
      # @room.status.must_be_kind_of FalseClass
    end

    it 'has a reservation' do
      @room.must_respond_to :reservations
      @room.reservations.must_be_kind_of Array #Hotel::Room.new ||
    end
  end #initialize


end # room
