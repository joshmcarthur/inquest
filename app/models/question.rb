class Question < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  validates :title, :presence => true
  validates :content, :presence => true

end
