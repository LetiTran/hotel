module Hotel
  class Block
    attr_reader

    def initialize(block_data)
      @date_range = block_data[:date_range]
      @rooms = block_data[:rooms]
      @discount_rate = block_data[:discount_rate]
    end

  end
end
