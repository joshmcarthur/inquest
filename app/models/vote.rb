class Vote < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include PublicActivity::Model

  tracked :owner => ->(controller, model) { controller && controller.send(:current_user) }
  
  belongs_to :voteable, :polymorphic => true, :counter_cache => true
  belongs_to :user

  validates :voteable, :user, :presence => true
  validates :direction, :inclusion => {:in => %w(up down)}

  scope :upvotes, :conditions => {:direction => 'up'}
  scope :downvotes, :conditions => {:direction => 'down'}

end
