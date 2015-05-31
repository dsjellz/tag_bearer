require 'spec_helper'

describe TagBearer::ActsAsTagBearer do

  describe '#tag' do
    let(:model) { TaggableModel.create }

    it 'creates a single tag' do
      model.tag key: 'Owner', value: 'someone'
      expect(model.tags).to have(1).match
    end

    it 'requires a key' do
      model.tag value: 'someone'
      expect(model.tags).to have(0).matches
    end

    it 'does not require a value' do
      model.tag key: 'someone'
      expect(model.tags).to have(1).match
    end

    it 'overwrites a tag with an existing key' do
      model.tag key: 'Owner', value: 'someone'
      expect(model.get_tag('Owner')).to eq 'someone'

      model.tag key: 'Owner', value: 'someone else'
      expect(model.get_tag('Owner')).to eq 'someone else'

      expect(model.tags).to have(1).match
    end
  end

  describe 'get_tag' do
    let(:model) { TaggableModel.create }

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

  describe 'full_sync!' do
    let(:model) { TaggableModel.create }

    before(:each) do
      model.tag key: 'first', value: 'first value'
      model.tag key: 'second', value: 'original value'
      model.tag key: 'third', value: 'on death row'

      model.full_sync!([
        {key: 'first', value: 'first value'},
        {key: 'second', value: 'updated value'},
      ])
    end

    it 'removes derelict keys' do
      expect(model.tags.count).to eq 2
    end

    it 'updates tag values' do
      expect(model.get_tag('second')).to eq 'updated value'
    end

    it 'ignores tags with no changes' do
      expect(model.get_tag('first')).to eq 'first value'
    end
  end

  describe 'tag_list' do
    let(:model) { TaggableModel.create }

    before(:each) do
      model.tag key: 'env', value: 'production'
      model.tag key: 'name', value: 'smithers'
    end

    it 'returns all tag keys' do
      expect(model.tag_list).to include 'env', 'name'
    end
  end

  describe '#with_tags' do
    let(:bran) { TaggableModel.create }
    let(:jaime) { TaggableModel.create }
    let(:sansa) { TaggableModel.create }
    let(:theon) { TaggableModel.create }

    before(:each) do
      bran.assign_tag home: 'winterfell', family: 'stark', gender: 'male'
      jaime.assign_tag home: 'casterly rock', family: 'lannister', gender: 'male'
      sansa.assign_tag home: 'winterfell', family: 'stark', gender: 'female'
      theon.assign_tag home: 'iron islands', family: 'greyjoy', gender: nil
    end

    it 'returns matches on a single parameter' do
      expect(TaggableModel.with_tags(home: 'winterfell')).to have(2).matches
    end

    it 'returns matches on multiple parameters' do
      expect(TaggableModel.with_tags(home: 'winterfell', family: 'stark')).to have(2).matches
    end

    it 'only returns matches on all parameters' do
      expect(TaggableModel.with_tags(gender: 'male', family: 'stark')).to have(1).match
    end

    it 'does not consider nil a match' do
      expect(TaggableModel.with_tags(gender: 'male', family: 'greyjoy')).to have(0).matches
    end
  end
end