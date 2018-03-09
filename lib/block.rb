module Hotel
  class Block
    attr_reader :id, :date_range, :rooms, :discount_rate

    def initialize(id:, date_range:, rooms:, discount_rate:)

      raise StandardError.new("Block cannot hold more than 5 rooms") if :rooms.length > 5 || :rooms.length < 2

      @id = id
      @date_range = date_range
      @rooms = rooms
      @discount_rate = discount_rate
    end

    def available_rooms
      available_rooms = rooms
      # puts "available_rooms = #{available_rooms}"
      #
      date_range.each do |date|
        rooms.each {|room| available_rooms.delete(room) if room.ocupied_on.include?(date)}
      end

      return available_rooms
    end
  end
end
