module Users::NotificationRulesHelper
  def class_name_options_for_select
    Inquest::Application.config.notifiable_classes.map { |nc| [nc.name.pluralize, nc.name] }
  end

  def action_options_for_select
    NotificationRule::ACTIONS.map { |a| ["#{a}d", a] }
  end

  
end
