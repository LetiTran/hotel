module Hotel
  class Reservation

    attr_reader :start_date, :end_date, :cost, :room, :id, :status, :nigth_rate, :block

    def initialize(reservation_id:, check_in:, check_out:, nigth_rate:, room:, block: nil)
      @id = reservation_id
      @start_date = check_in
      @end_date =  check_out
      @block = block
      @nigth_rate = @block.nil? ? nigth_rate : @block.discount_rate
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

    def status?
      # Not requirement, but could be used in future.
      true if end_date > Date.today
    end
  end
end
