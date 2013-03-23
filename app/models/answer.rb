class Answer < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user
  belongs_to :question

  validates :content, :presence => true

  def accept!
    self.update_attribute(:accepted_at, DateTime.now)
  end
end
