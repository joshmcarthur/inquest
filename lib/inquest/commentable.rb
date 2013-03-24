module Inquest::Commentable

  def self.included(base)
    base.class_eval do
      has_many :comments, :as => :commentable
    end
  end
end
