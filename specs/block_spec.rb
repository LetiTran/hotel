require_relative 'spec_helper'
describe 'Block' do
  describe 'initialize' do
    before do
      @manager = Hotel::Manager.new
      @manager.create_block('3rd Feb 2020','5 Feb 2020', [1,2,3], 150)
    end
    it "can be created" do
      @manager.blocks[0].must_be_kind_of Hotel::Block
    end
  end
end
