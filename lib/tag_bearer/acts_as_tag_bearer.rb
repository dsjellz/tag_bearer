require 'tag_bearer/acts_as_tag_bearer'
require 'tag_bearer/tag'

module TagBearer

  def self.tag_table=(name)
    TagBearer::Tag.table_name = name
  end

  module ActsAsTagBearer
    extend ActiveSupport::Concern

    included do; end

    module ClassMethods
      def acts_as_tag_bearer(options = {})
        has_many :tags, as: :taggable, class_name: Tag
        include TagBearer::ActsAsTagBearer::LocalInstanceMethods
      end

      def find_matches(conditions)
        TagBearer::Tag.select(:taggable_id)
          .where(taggable_type: name)
          .where("(#{TagBearer::Tag.table_name}.key, #{TagBearer::Tag.table_name}.value) IN (#{conditions.join(',')})")
          .group(:taggable_id, :taggable_type)
          .having("COUNT(distinct #{TagBearer::Tag.table_name}.key)=#{conditions.size}").pluck(:taggable_id)
      end

      def with_tags(params)
        conditions = params.map{ |condition| "('#{condition[0].to_s}', '#{condition[1].to_s}')" }
        matches = find_matches conditions
        matches.any? ? (name.constantize.find matches) : []
      end
    end

    module LocalInstanceMethods
      def assign_tag(params)
        params.keys.each_with_index do |key, index|
          tags.where(key: key).first_or_create.update(value: params.values[index])
        end
      end

      def full_sync!(params)
        params.each{ |t| tag(t) }
        tags.where.not(key: params.map{|t| t[:key]}).destroy_all
      end

      def get_tag(tag)
        tags.find_by(key: tag).try :value
      end

      def tag_list
        tags.pluck(:key)
      end

      def tag(params)
        tags.where(key: params[:key]).first_or_create.update(value: params[:value])
      end

    end
  end
end

ActiveRecord::Base.send :include, TagBearer::ActsAsTagBearer