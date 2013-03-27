class NotificationRule < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  ACTIONS = %w( create update )

  belongs_to :user
  validates :class_name, :inclusion => {:in => Inquest::Application.config.notifiable_classes.map { |c| c.name } }
  validates :reactor_name, :inclusion => {:in => proc { Inquest::Reactor.subclasses.map { |r| r.name } } } 
  validates :action, :inclusion => {:in => ACTIONS}

  def reactor
    Inquest::Reactor.subclasses.select do |sc|
      sc.name == self.reactor_name.to_s 
    end.first
  end
end
