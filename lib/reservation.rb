module Hotel
  class Reservation

    attr_reader :date , :cost, :room, :reservation_id

    def initialize
      @reservation_id = 1
      @date = get_date
      @cost = calculate_cost
      @room = select_room
    end

    def get_date

    end

    def calculate_cost

    end

    def select_room

    end
  end
end
