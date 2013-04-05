Disclosure.configure do |config|
  config.notifier_classes = []
end

Disclosure::EmailReactor.class_eval do
  def self.reaction_description 
    "send me an email"
  end
end

PublicActivity::Activity.send(:include, Inquest::DisclosureActivity)