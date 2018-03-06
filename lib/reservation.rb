# require 'Date'
# require 'pry'

module Hotel
  class Reservation

    # Date._parse('2001-02-03') #=> {:year=>2001, :mon=>2, :mday=>3}
    attr_reader :start_date, :end_date, :cost, :room, :id, :status, :nigth_rate

    def initialize(new_reservation_data)
      @id = new_reservation_data[:reservation_id]
      @start_date = new_reservation_data[:check_in]
      @end_date =  new_reservation_data[:check_out]
      @nigth_rate = 200
      @cost = calculate_cost
      @room = new_reservation_data[:room]
      @status = status? ? :OPEN : :CLOSED
    end

    def num_of_nights
      (end_date - start_date).to_i
    end

    def calculate_cost
      (num_of_nights * nigth_rate).round(2)
    end

    def status?
      true if end_date > Date.new(2018,3,5)
    end
  end
end
