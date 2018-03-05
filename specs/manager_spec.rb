require_relative 'spec_helper'

describe 'Manager' do
  describe 'initialize' do
    it "can be created" do
      manager = Hotel::Manager.new
      manager.must_be_kind_of Hotel::Manager
    end

    it 'has collections of rooms' do
      manager = Hotel::Manager.new
      manager.must_respond_to :rooms
      manager.rooms.must_be_kind_of Array
    end

    it 'has collections of reservations' do
      manager = Hotel::Manager.new
      manager.must_respond_to :reservations
      manager.reservations.must_be_kind_of Array
    end
  end #initialize


end # manager
