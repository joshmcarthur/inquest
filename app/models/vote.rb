class Vote < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :votable, :polymorphic => true
  belongs_to :user

  validates :votable, :user, :presence => true
  validates :direction, :inclusion => {:in => %w(up down)}
  
end
