module Hotel
  class Manager
    attr_reader :all_rooms, :all_reservations

    def initialize
      @all_rooms = initialize_all_rooms
      @all_reservations = Array.new
    end

    def initialize_all_rooms
      all_rooms = []
      20.times {|i| all_rooms << Hotel::Room.new(i + 1)}
      return all_rooms
    end

    def add_reservation

    end

    def select_room

    end

  end
end
