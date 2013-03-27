class NotificationRule < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user
  validates :class_name, :inclusion => {:in => Inquest::Application.config.notifiable_classes.map(&:name) }
  validates :reactor_name, :inclusion => {:in => Inquest::Application.config.reactor_classes.map(&:name) } 
  validate :action_in_class_notifiable_actions

  validates :action, :uniqueness => {:scope => [:user_id, :class_name] }

  def klass
    Inquest::Application.config.notifiable_classes.select do |nc|
      nc.name == self.class_name.to_s
    end.first
  end

  def reactor
    Inquest::Application.config.reactor_classes.select do |sc|
      sc.name == self.reactor_name.to_s 
    end.first
  end

  private

  # Private: Ensure that the configured action is within the 
  # notiable actions recorded against the class.
  #
  # For example, a Question may notify actions such as:
  # * downvoted
  # * answered
  #
  # While an Answer may only notify voting and commenting actions
  #
  # Returns true if the action is valid, or false if not
  def action_in_class_notifiable_actions
    unless klass && klass.notifiable_actions.include?(self.action)
      errors.add(:actions, :not_in_notifiable_actions)
      return false
    end

    return true
  end
end
