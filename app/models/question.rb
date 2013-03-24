class Question < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include Inquest::Voteable
  include Inquest::Commentable
  include Inquest::ContentMarkdownable
  include PublicActivity::Model

  tracked :owner => ->(controller, model) { controller && controller.send(:current_user) }

  belongs_to :user
  has_one :accepted_answer, :class_name => 'Answer', :conditions => 'accepted_at IS NOT NULL'
  has_many :answers, :order => 'accepted_at, votes_count DESC'
  has_many :votes, :as => :voteable
  has_and_belongs_to_many :tags

  validates :title, :presence => true
  validates :content, :presence => true

  before_save :timestamp_state_change, :if => :state_changed?
  validate :validate_existing_of_tags

  # Public: To store the tags as a string
  # This instance variable will be use for validate_existing_of_tags
  # validate method to split the string to array by ','
  attr_writer :tags_string

  # Public: Render the Markdown content of this question as HTML.
  #
  # This method uses the Redcarpet library to convert the Markdown
  # question content into HTML for rendering into a view.
  #
  # #FIXME it should also handle sanitizing the output, stripping potentially
  # dangerous or disallowed tags.
  #
  # Returns the generated HTML for the question content
  def content_html
    Inquest::Application.config.markdown_renderer.render(self.content).html_safe
  end

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


  # Public: Define the actions that are notifiable for this model.
  # Returns an array of notifiable actions
  def self.notifiable_actions
    %w( create )
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

  def tags_string
    @tags_string || tags.pluck(:title).join(',')
  end


  private

  # Private: Validate the tag string contain all the tags that exist
  # Add errors if tags is not exist
  def validate_existing_of_tags
    unless tags_string.nil?
      tags_array = tags_string.split(',').inject([]) do |memo, tag_string|
        if tag = Tag.find_by_title(tag_string.strip)
          memo << tag
        else
          errors.add :tags,  "#{tag_string} is not valid"
        end
        memo
      end
      self.tags = tags_array
    end
  end

end
