class Question < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user
  has_many :answers

  validates :title, :presence => true
  validates :content, :presence => true
end
