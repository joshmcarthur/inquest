class Tag < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :questions
end
