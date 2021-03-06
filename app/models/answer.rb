class Answer < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include Inquest::Voteable
  include Inquest::Commentable
  include Inquest::ContentMarkdownable
  include PublicActivity::Model

  tracked :owner => ->(controller, model) { controller && controller.send(:current_user) }

  belongs_to :user
  belongs_to :question

  validates :content, :presence => true


  # Public: Define the actions that are notifiable for this model.
  # Returns an array of notifiable actions
  def self.notifiable_actions
    %w( accepted )
  end


  # Public: Mark this answer as accepted by updating the accepted_at timestamp.
  #
  # Examples
  #
  #   accept!
  #   # => <Answer accepted_at=timestamp>
  #
  # Returns the updated object
  def accept!
    Answer.public_activity_off
    self.update_attribute(:accepted_at, DateTime.now)
    Answer.public_activity_on
    
    self.create_activity :key => 'answer.accepted', :owner => self.question.user
    self
  end


  # Public: Determine whether this answer has been accepted.
  #
  # Returns true if the answer is accepted, or false if not
  def accepted?
    !self.accepted_at.nil?
  end

  # Public: Determine whether this answer may be answered.
  #
  # An answer is answerable if the question's accepted
  # answer is nil - otherwise, another answer has been
  # selected, and so this answer cannot be accepted.
  #
  # Examples:
  #
  #   # When question.accepted_answer is not nil
  #   answerable? 
  #   # => false
  #
  #   # When question.accepted_answer is nil
  #   answerable?
  #   # => true
  #
  # Returns true if this answer is answerable, or false if not
  def acceptable?
    return false if self.question.nil?
    self.question.accepted_answer.nil?
  end

end
