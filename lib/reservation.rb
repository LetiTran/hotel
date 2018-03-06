require 'Date'
# require 'pry'

module Hotel
  class Reservation

    # Date._parse('2001-02-03') #=> {:year=>2001, :mon=>2, :mday=>3}
    attr_reader :start_date, :end_date, :cost, :room, :reservation_id, :status, :rate

    def initialize(start_date, end_date, room, rate)
      @reservation_id = 1
      @start_date = Date.parse(start_date)
      @end_date =  Date.parse(end_date)
      @rate = rate
      @cost = calculate_cost
      @room = room
      @status = status? ? :OPEN : :CLOSED
    end

    def num_of_nights
      (end_date - start_date).to_i
    end

    def calculate_cost
      num_of_nights.to_i * @rate.to_i
    end

    def status?
      true if end_date > Date.new(2018,3,5)
    end
  end
end
