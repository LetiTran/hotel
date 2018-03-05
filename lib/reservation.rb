require 'Date'
module Hotel
  class Reservation

    # Date._parse('2001-02-03') #=> {:year=>2001, :mon=>2, :mday=>3}
    attr_reader :start_date, :end_date, :cost, :room, :reservation_id, :status

    def initialize(start_date, end_date)
      @reservation_id = 1
      @start_date = Date.parse(start_date)
      # Date.parse()
      @end_date =  Date.parse(end_date)
      # Date.parse('3rd Feb 2001')
      @cost = calculate_cost
      @room = select_room
      @status = status? ? :OPEN : :CLOSED
    end

    def num_of_nights
      (end_date - start_date).to_i
    end

    def select_room

    end

    def calculate_cost
      num_of_nights * 200
    end

    def status?
      true if end_date > Date.new(2018,3,5)
    end
  end
end
