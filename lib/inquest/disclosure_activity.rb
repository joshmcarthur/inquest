module Inquest
  module DisclosureActivity
    def self.included(base)
      base.class_eval do
        after_save :find_and_notify!

        private

        def find_and_notify!
          Disclosure::Rule.where(
            :notifier_class => self.trackable.class.name,
            :action => self.key.split('.').last
            ).each do |rule|
            rule.react!(self.trackable)
          end
        end
      end
    end
  end
end
