module Inquest
  module Taggable
    def self.included(base)
      base.class_eval do
        has_and_belongs_to_many :tags

        def tags_list=(new_tags)
          new_tags.split(',').each do |tag_name|
            if tag = Tag.where(:name => tag_name.strip).first
              self.tags << tag
            end
          end
        end

        def tags_list
          self.tags.map(&:name)
        end
      end
    end
  end
end