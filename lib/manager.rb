module Hotel
  class Manager
    attr_reader :all_rooms, :all_reservations

    def initialize
      @all_rooms = Array.new(20)
      @all_reservations = Array.new
    end
    def all_reservations
      return [1, 2]
    end
  end
end
