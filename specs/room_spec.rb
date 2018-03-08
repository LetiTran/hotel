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
      @room.must_respond_to :id
      @room.id.must_be_kind_of Integer
    end

    it 'has reservations' do
      manager = Hotel::Manager.new
      new_reservation = manager.add_reservation('3rd Feb 2020','5 Feb 2020')

      @room.must_respond_to :ocupied_on
      @room.ocupied_on.must_be_kind_of Array
      new_reservation.room.ocupied_on[0].must_be_kind_of Date
    end
  end #initialize


end # room
