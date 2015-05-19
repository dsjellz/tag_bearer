class TaggableModel < ActiveRecord::Base
  self.table_name = 'taggable_model'
  acts_as_tag_bearer
end