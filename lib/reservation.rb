module Hotel
  class Reservation

    attr_reader :date , :cost, :room, :reservation_id, :status

    def initialize
      @reservation_id = 1
      @date = get_date
      @cost = calculate_cost
      @room = select_room
      @status = status? ? :OPEN : :CLOSED
    end

    def get_date

    end

    def calculate_cost

    end

    def select_room

    end

    def status?
      true if get_date.to_i < Time.now.to_i
    end
  end
end
