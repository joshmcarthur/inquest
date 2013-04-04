module Users::NotificationRulesHelper
  def class_name_options_for_select
    Disclosure.configuration.notifier_classes.map { |nc| [nc.name.pluralize, nc.name] }
  end
end
