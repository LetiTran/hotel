module Hotel
  class Room

    attr_reader :nigth_rate, :id, :ocupied_on

    def initialize(id)
      @id = id
      @nigth_rate = 200
      @ocupied_on = []
    end
  end
end
