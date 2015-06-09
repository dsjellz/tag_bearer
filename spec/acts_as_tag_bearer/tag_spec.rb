require 'spec_helper'

describe TagBearer::Tag do
  describe '#resources_with_tag' do
    let(:model) { TaggableModel.create }
    let(:another_model) { TaggableModel.create }
    let(:another_taggable_model) { AnotherTaggableModel.create }

    before(:each) do
      another_model.tag key: 'owner', value: 'Jim Lahey'
      model.tag key: 'owner', value: 'Jim Lahey'
      another_taggable_model.tag key: 'owner', value: 'Jim Lahey'
    end

    it 'finds all taggable_types' do
      resources = TagBearer::Tag.resources_with_tag(owner: 'Jim Lahey')
      expect(resources.keys).to include(:TaggableModel, :AnotherTaggableModel)
    end

  end
end