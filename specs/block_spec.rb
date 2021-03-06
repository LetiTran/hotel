require_relative 'spec_helper'
describe 'Block' do
  describe 'initialize' do
    before do
      @manager = Hotel::Manager.new
      date_range = (Date.parse('3 Feb 2020')..Date.parse('5 Feb 2020')).map{|date| date}

      block_data = {id: @manager.blocks.length + 1, date_range: date_range, rooms: [1,2,3], discount_rate: 150}
      @block = Hotel::Block.new(block_data)
    end

    it "can be created" do
      @block.must_be_kind_of Hotel::Block
    end

    it 'has an id' do
      @block.must_respond_to :id
      @block.id.must_be_kind_of Integer
      @block.id.must_be :>, 0
    end

    it 'has a discount rate' do
      @block.must_respond_to :discount_rate
      @block.discount_rate.must_be_kind_of Integer
      @block.discount_rate.must_be :>=, 0
    end

    it 'has a date range' do
      @block.must_respond_to :date_range
      @block.date_range.must_be_kind_of Array
    end

    it 'has a collection of rooms' do
      @block.must_respond_to :rooms
      @block.rooms.must_be_kind_of Array
      @block.rooms[0].must_be_kind_of Integer
    end

    it 'has max 5 rooms' do
      date_range = (Date.parse('3 Feb 2020')..Date.parse('5 Feb 2020')).map{|date| date}
      block_data = {date_range: date_range, rooms: [1,2,3,4,5,6], discount_rate: 150}

      proc {@block.Hotel::Block.new(block_data)}.must_raise StandardError
    end

    it 'has min 2 rooms' do
      date_range = (Date.parse('3 Feb 2020')..Date.parse('5 Feb 2020')).map{|date| date}
      block_data = {date_range: date_range, rooms: [1], discount_rate: 150}

      proc {@block.Hotel::Block.new(block_data)}.must_raise StandardError
    end

    it 'has a collection of available rooms' do
      @block.must_respond_to :available_rooms
      @block.rooms.must_be_kind_of Array
      @block.rooms[0].must_be_kind_of Integer
      @block.rooms.length.must_equal 3
    end
  end

  describe 'mark_reserved_room' do
    it 'delete a room from the available rooms list' do
      #Create new block:
      manager = Hotel::Manager.new
      block = manager.create_block('3 Feb 2020', '5 Feb 2020',[1,2,3],  150)

      # Assertion 1:
      block.available_rooms.length.must_equal 3
      block.available_rooms.must_be_kind_of Array

      # Reserve a room of this block:
      manager.reserve_room_in_block(1, room: 2)
      # Assertion 2:
      block.available_rooms.length.must_equal 2
    end
  end
end
