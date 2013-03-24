class Vote < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :voteable, :polymorphic => true
  belongs_to :user

  validates :voteable, :user, :presence => true
  validates :direction, :inclusion => {:in => %w(up down)}

end
