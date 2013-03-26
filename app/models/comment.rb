class Comment < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include PublicActivity::Model

  tracked :owner => ->(controller, model) { controller && controller.send(:current_user) }
  
  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  validates :commentable, :user, :content, :presence => true
end
