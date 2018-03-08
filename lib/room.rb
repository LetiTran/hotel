# require_relative 'reservation'
# require_relative 'manager'

module Hotel
  class Room

    attr_accessor :nigth_rate, :id, :ocupied_on

    def initialize(id)
      @id = id
      @nigth_rate = 200
      @ocupied_on = []
    end

    # def available?
    #
    # end
  end
end
