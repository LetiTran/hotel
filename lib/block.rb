module Hotel
  class Block
    attr_reader :date_range, :rooms, :discount_rate

    def initialize(block_data)
      raise StandardError.new("Block cannot hold more than 5 rooms") if block_data[:rooms].length > 5

      @date_range = block_data[:date_range]
      @rooms = block_data[:rooms]
      @discount_rate = block_data[:discount_rate]
    end

  end
end
