module Inquest
  module Taggable
    def self.included(base)
      base.class_eval do
        has_and_belongs_to_many :tags

        def tags_list=(new_tags)
          new_tags.each do |tag_name|
            self.tags << Tag.where(:name => tag_name).first
          end
        end

        def tags_list
          self.tags.pluck(:name)
        end
      end
    end
  end
end