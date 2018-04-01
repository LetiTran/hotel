require_relative 'manager'
module Hotel
  class Block < Manager
    attr_reader :id, :date_range, :rooms, :discount_rate

    def initialize(id:, date_range:, rooms:, discount_rate:)

      raise StandardError.new("Block cannot hold more than 5 rooms") if :rooms.length > 5 || :rooms.length < 2

      @id = id
      @date_range = date_range
      @rooms = rooms
      # @available_rooms = rooms
      # @reserved_rooms = []
      @discount_rate = discount_rate
    end

    # def available_rooms
    #   available_rooms = rooms
    #   # TODO: DRY
    #   date_range.each do |date|
    #     # available_rooms.delete_if {|room| room.ocupied_on.include?(date) }
    #     available_rooms.each do |room|
    #       Manager.all_reservations.each do |reservation|
    #         all_res.each do |reservation|
    #           if reservation.room == room
    #             if  get_date_range(reservation.start_date, reservation.end_date).include?(date)
    #               available_rooms.delete(room)
    #             end
    #           end
    #         end
    #       end
    #     end
    #
    #     return available_rooms
    #   end
    # end
  end
end
