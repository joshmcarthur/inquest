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

  before_save :timestamp_state_change, :if => :state_changed?


  # Public: Determine whether this question is owned by the given user.
  #
  # Simple shortcut to tidy up views.
  # Returns true if the question is owned by the user, false otherwise.
  def owned_by?(user)
    self.user == user
  end

  # Public: Return whether this question is 'available' or not.
  # Available means whether it has a state set which prevents anyone from 
  # changing it, as determined by unavailable_states
  #
  # Returns true if the question is available, and false if not.
  def available?
    !self.class.unavailable_states.include?(self.state)
  end

  # Public: Return the states available to the question.
  #
  # Returns an array of available states
  def self.states
    %w( closed irrelevant duplicate )
  end

  def self.unavailable_states
    self.states
  end

  private

  # Private: Update the state changed timestamp.
  # 
  # This callback is fired to update a datetime attribute
  # which reflects when the state was last changed. This
  # allows us to display handy information in the view, such
  # as 'Question closed by <user> at <date>'
  # 
  # Returns the object
  def timestamp_state_change
    self.state_last_updated = DateTime.now if state_changed?
    self
  end
end
