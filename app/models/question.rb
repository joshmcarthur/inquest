class Question < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include Inquest::Voteable

  belongs_to :user
  has_one :accepted_answer, :class_name => 'Answer', :conditions => 'accepted_at IS NOT NULL'
  has_many :answers, :order => 'accepted_at, votes_count DESC'

  validates :title, :presence => true
  validates :content, :presence => true

  before_save :timestamp_state_change, :if => :state_changed?


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
