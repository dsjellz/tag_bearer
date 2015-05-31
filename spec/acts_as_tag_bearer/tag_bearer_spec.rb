require 'spec_helper'

describe TagBearer do
  describe '#tag_table' do
    let(:new_table_name) { 'taggable' }

    it 'changes the table name' do
      TagBearer.tag_table = new_table_name
      expect(TagBearer::Tag.table_name).to eq new_table_name
    end

  end
end