class Tag < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  attr_accessor :title
end
