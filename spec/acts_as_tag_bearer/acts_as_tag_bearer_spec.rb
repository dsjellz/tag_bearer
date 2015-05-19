require 'spec_helper'

describe TagBearer::ActsAsTagBearer do

  describe '#add_tag' do
    let(:model) { TaggableModel.new }

    it 'creates a single tag' do
      model.tag key: 'Owner', value: 'someone'
      expect(model.get_tags.size).to eq 1
    end

    it 'requires a key' do
      model.tag value: 'someone'
      expect(model.get_tags.size).to eq 0
    end

    it 'does not require a value' do
      model.tag key: 'someone'
      expect(model.get_tags.size).to eq 1
    end

    it 'overwrites a tag with an existing key' do
      model.tag key: 'Owner', value: 'someone'
      expect(model.get_tag('Owner')).to eq 'someone'

      model.tag key: 'Owner', value: 'someone else'
      expect(model.get_tag('Owner')).to eq 'someone else'

      expect(model.get_tags.size).to eq 1
    end
  end

  describe '#get_tag' do
    let(:model) { TaggableModel.new }

    before(:each) do
      model.tag key: 'env', value: 'test'
    end

    it 'returns a tag by name' do
      expect(model.get_tag('env')).to eq 'test'
    end

    it 'returns nil if the tag does not exist' do
      expect(model.get_tag('fake tag')).to be_nil
    end

  end
end