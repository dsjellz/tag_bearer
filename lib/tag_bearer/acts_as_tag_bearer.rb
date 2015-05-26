require 'tag_bearer/acts_as_tag_bearer'
require 'tag_bearer/tag'

module TagBearer
  module ActsAsTagBearer
    extend ActiveSupport::Concern

    included do; end

    module ClassMethods
      def acts_as_tag_bearer(options = {})
        has_many :tags, as: :taggable, class_name: Tag
        include TagBearer::ActsAsTagBearer::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods
      def assign_tag(params)
        params.keys.each_with_index do |key, index|
          tags.where(key: key).first_or_create.update(value: params.values[index])
        end
      end

      # params = [{key: 'Owner', value: 'someone'}]
      def full_sync!(params)
        params.each{ |t| tag(t) }
        remove_derelict_tags(params)
      end

      # 'Owner'
      def get_tag(tag)
        tags.find_by(key: tag).try :value
      end

      # keys = %w(Owner Environment)
      def get_tags(keys = [])
        tags
      end

      def owned_tags
        tags.pluck(:key)
      end

      # params = {key: 'Owner', value: 'someone'}
      def tag(params)
        tags.where(key: params[:key]).first_or_create.update(value: params[:value])
      end

      private

      def remove_derelict_tags(params)
        tags.where.not(key: params.map{|t| t[:key]}).destroy_all
      end

    end
  end
end

ActiveRecord::Base.send :include, TagBearer::ActsAsTagBearer