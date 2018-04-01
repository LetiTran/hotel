module Hotel
  class Block
    attr_reader :id, :date_range, :rooms, :discount_rate, :available_rooms

    def initialize(id:, date_range:, rooms:, discount_rate:)

      raise StandardError.new("Block cannot hold more than 5 rooms") if :rooms.length > 5 || :rooms.length < 2

      @id = id
      @date_range = date_range
      @rooms = rooms
      @available_rooms = rooms
      @discount_rate = discount_rate
    end

    def mark_reserved_room(room)
      @available_rooms.delete(room)
    end

  end
end
