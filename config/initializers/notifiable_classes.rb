# Set classes that can be notified when
# actions happen to them
Inquest::Application.config.notifiable_classes = [Question, Answer]

# Include the notifiable module to make sure they conform to what a notifiable model must do
Inquest::Application.config.notifiable_classes.each do |klass|
  unless klass.included_modules.include?(Inquest::Notifiable)
    Rails.logger.warn "#{klass.name} does not include Inquest::Notifiable, so may not work correctly."
  end
end

# Set classes that can react to events on notifiable classes.
# These classes should inherit from Inquest::Reactor
Inquest::Application.config.reactor_classes = [EmailReactor]
