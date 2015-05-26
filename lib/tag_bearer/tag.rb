require 'active_record'

module TagBearer
  class Tag < ActiveRecord::Base
    belongs_to :taggable, polymorphic: true
    self.table_name = 'tags'
    validates_presence_of :key
  end
end