class Tag < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  validate :name, uniqueness: true, allow_blank: false

  has_and_belongs_to_many :questions
end
