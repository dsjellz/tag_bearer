RSpec.shared_examples 'a valid adapter' do
  let(:collection) { described_class.new([7, 2, 4]) }

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