require_relative 'spec_helper'

describe 'Reservation' do
  describe 'initialize' do
    before do
      @manager = Hotel::Manager.new
      @reservation = Hotel::Reservation.new
    end

    it "can be created" do
      @reservation.must_be_kind_of Hotel::Reservation
    end

    it 'has an id' do
      @reservation.must_respond_to :reservation_id
      @reservation.reservation_id.must_be_kind_of Integer
    end

    it 'has a status' do
      @reservation.must_respond_to :status
      @reservation.status.must_be_kind_of Symbol
      # @reservation.status.must_be_kind_of FalseClass
    end

    it 'has a room' do
      @reservation.must_respond_to :room
      # @reservation.reservation_reservations.must_be_kind_of Hotel::Room
    end
  end
end
