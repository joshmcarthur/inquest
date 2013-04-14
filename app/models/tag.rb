class Tag < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  validate :name, uniqueness: true, allow_blank: false
end
