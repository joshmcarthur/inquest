class Comment < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  validates :commentable, :user, :content, :presence => true
end
