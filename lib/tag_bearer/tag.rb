require 'active_record'

module TagBearer
  class Tag < ActiveRecord::Base
    self.table_name = 'tag_bearer_tags'

    validates_presence_of :key

  end
end