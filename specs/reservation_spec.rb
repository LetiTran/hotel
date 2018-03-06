require_relative 'spec_helper'

describe 'Reservation' do
  describe 'initialize' do
    before do
      @room = Hotel::Room.new(1)
      @manager = Hotel::Manager.new
      @reservation = Hotel::Reservation.new({reservation_id: 1, check_in: Date.parse('3rd Feb 2019'), check_out: Date.parse('5 Feb 2019'), room: @room})
    end

    it "can be created" do
      @reservation.must_be_kind_of Hotel::Reservation
    end

    it 'has an id' do
      @reservation.must_respond_to :id
      @reservation.id.must_be_kind_of Integer
    end

    it 'has a status' do
      @reservation.must_respond_to :status
      @reservation.status.must_be_kind_of Symbol
      # @reservation.status.must_be_kind_of FalseClass
    end

    it 'has a room' do
      @reservation.must_respond_to :room
      @reservation.room.must_be_kind_of Hotel::Room
    end

    it 'has start and end dates' do
      @reservation.must_respond_to :start_date
      @reservation.start_date.must_be_kind_of Date

      @reservation.must_respond_to :end_date
      @reservation.end_date.must_be_kind_of Date
    end

    it 'has a rate' do
      @reservation.must_respond_to :nigth_rate
      @reservation.id.must_be_kind_of Integer
    end

    it 'has a cost' do
      @reservation.must_respond_to :cost
      @reservation.cost.must_equal 400
    end

    it 'has a status' do
      @reservation.must_respond_to :status
      @reservation.status.must_equal :OPEN

      reservation2 = Hotel::Reservation.new({reservation_id: 1, check_in: Date.parse('3rd Feb 2018'), check_out: Date.parse('5 Feb 2018'), room: @room})
      reservation2.status.must_equal :CLOSED
    end

  end

  describe '#num_of_nights' do
    it 'calculates the number of nights' do
      @room = Hotel::Room.new(1)
      reservation = Hotel::Reservation.new({reservation_id: 1, check_in: Date.parse('3rd Feb 2019'), check_out: Date.parse('5 Feb 2019'), room: @room})
      reservation.num_of_nights.must_equal 2
      reservation.num_of_nights.must_be_kind_of Integer
    end
  end

  describe '#calculate_cost' do
    it 'calculates the cost of the stay' do
      @room = Hotel::Room.new(1)
      reservation = Hotel::Reservation.new({reservation_id: 1, check_in: Date.parse('3rd Feb 2019'), check_out: Date.parse('5 Feb 2019'), room: @room})
      reservation.calculate_cost.must_equal 2 * 200
      reservation.calculate_cost.must_be_kind_of Integer
    end
  end
end #Reservation
