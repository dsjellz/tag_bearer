require 'active_record'

module TagBearer
  class Tag < ActiveRecord::Base
    belongs_to :taggable, polymorphic: true
    validates_presence_of :key

    def self.resources_with_tag(params)
      tag = params.keys[0]
      matches = TagBearer::Tag.where key: tag, value: params[tag]
      result = {}

      matches.map(&:taggable_type).uniq.each do |taggable_type|
        ids = matches.select{|m| m.taggable_type == taggable_type}.map(&:taggable_id)
        result[taggable_type.to_sym] = taggable_type.constantize.find ids
      end
      result
    end

  end
end