class NotificationRule < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  ACTIONS = [:create, :update]

  belongs_to :user
  validates :class_name, :inclusion => {:in => Inquest::Application.config.notifiable_classes }
  validates :reactor_name, :inclusion => {:in => Reactor.subclasses.map(&:name) } 
  validates :action, :inclusion => {:in => ACTIONS}
end
