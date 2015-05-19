require 'tag_bearer/acts_as_tag_bearer'
require 'tag_bearer/tag'

module TagBearer
  module ActsAsTagBearer
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_tag_bearer(options = {})
        include TagBearer::ActsAsTagBearer::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods
      def assign_tag(tags)
        tags.keys.each_with_index do |key, index|
          Tag.where(owner_params.merge(key: key)).first_or_create.update(value: tags.values[index])
        end
      end

      # params = [{key: 'Owner', value: 'someone'}]
      def full_sync!(tags)
        tags.each{ |t| tag(t) }
        remove_derelict_tags(tags)
      end

      # 'Owner'
      def get_tag(tag)
        Tag.find_by(owner_params.merge(key: tag)).try :value
      end

      # keys = %w(Owner Environment)
      def get_tags(keys = [])
        Tag.where(keys.empty? ? owner_params : owner_params.merge(key: keys))
      end

      def owned_tags
        Tag.where(owner_params).pluck(:key)
      end

      # params = {key: 'Owner', value: 'someone'}
      def tag(params)
        Tag.where(owner_params.merge(key: params[:key])).first_or_create.update(value: params[:value])
      end

      private

      def remove_derelict_tags(tags)
        Tag.where(owner_params).where.not(key: tags.map{|t| t[:key]}).destroy_all
      end

      def owner_params
        {owner_id: self.id, owner_class: self.class.name}
      end
    end
  end
end

ActiveRecord::Base.send :include, TagBearer::ActsAsTagBearer