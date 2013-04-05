module Users::NotificationRulesHelper
  def class_name_options_for_select
    [Question, Answer].map { |nc| [nc.name.pluralize, nc.name] }
  end

  def action_options_for_select(klass)
    klass.notifiable_actions.map { |action| [action.gsub(/[e|ed]*\Z/, '') + 'ed', action] }
  end
end
