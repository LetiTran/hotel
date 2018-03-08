require_relative 'spec_helper'
describe 'Block' do
  describe 'initialize' do
    before do
      @manager = Hotel::Manager.new
      date_range = (Date.parse('3 Feb 2020')..Date.parse('5 Feb 2020')).map{|date| date}

      block_data = {date_range: date_range, rooms: [1,2,3], discount_rate: 150}
      @block = Hotel::Block.new(block_data)
    end

    it "can be created" do
      @block.must_be_kind_of Hotel::Block
      # @manager.blocks[0].must_be_kind_of Hotel::Block
    end

    it 'has a discount rate' do
      @block.must_respond_to :discount_rate
      @block.discount_rate.must_be_kind_of Integer
    end

    it 'has a date range' do
      @block.must_respond_to :date_range
      @block.date_range.must_be_kind_of Array
    end

    it 'has a collection of rooms' do
      @block.must_respond_to :rooms
      @block.rooms.must_be_kind_of Array
    end

    it 'has max 5 rooms' do
      date_range = (Date.parse('3 Feb 2020')..Date.parse('5 Feb 2020')).map{|date| date}
      block_data = {date_range: date_range, rooms: [1,2,3,4,5,6], discount_rate: 150}

      proc {@block.Hotel::Block.new(block_data)}.must_raise StandardError
    end

  end
end
