class Question < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :answers

  validates :title, :presence => true
  validates :content, :presence => true
end
