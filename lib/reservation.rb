# require 'Date'
# require 'pry'

module Hotel
  class Reservation

    # Date._parse('2001-02-03') #=> {:year=>2001, :mon=>2, :mday=>3}
    attr_reader :start_date, :end_date, :cost, :room, :id, :status, :nigth_rate
# new_reservation_data
    def initialize(reservation_id:, check_in:, check_out:, nigth_rate:, room:)
      @id = reservation_id
      @start_date = check_in
      @end_date =  check_out
      @nigth_rate = nigth_rate
      @cost = calculate_cost
      @room = room
      @status = status? ? :OPEN : :CLOSED
    end

    def num_of_nights
      (end_date - start_date).to_i
    end

    def calculate_cost
      (num_of_nights * nigth_rate).round(2)
    end

#TODO why?? fix this
    def status?
      true if end_date > Date.new(2018,3,5)
    end
  end
end
