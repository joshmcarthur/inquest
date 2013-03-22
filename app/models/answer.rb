class Answer < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  
  validates :content, :presence => true
end
