class Question < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include Inquest::Voteable
  include Inquest::Commentable
  include Inquest::ContentMarkdownable

  belongs_to :user
  has_one :accepted_answer, :class_name => 'Answer', :conditions => 'accepted_at IS NOT NULL'
  has_many :answers, :order => 'accepted_at, votes_count DESC'

  validates :title, :presence => true
  validates :content, :presence => true


  # Public: Determine whether this question is owned by the given user.
  #
  # Simple shortcut to tidy up views.
  # Returns true if the question is owned by the user, false otherwise.
  def owned_by?(user)
    self.user == user
  end
end
