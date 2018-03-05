module Hotel
  class Manager
    attr_reader :rooms, :reservations

    def initialize
      @rooms = Array.new(20)
      @reservations = Array.new
    end

  end
end
