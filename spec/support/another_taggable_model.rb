class AnotherTaggableModel < ActiveRecord::Base
  self.table_name = 'another_taggable_model'
  acts_as_tag_bearer
end