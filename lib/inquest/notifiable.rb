module Inquest::Notifiable
  def self.included(base)
    base.class_eval do
      def self.notifiable_actions
        raise <<-ERROR
         Notifiable actions not yet defined for this model. 
         Please define a class method called notifiable_actions 
         which returns an array of string actions
         ERROR
      end
    end
  end
end