class Question < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user
  has_one :accepted_answer, :class_name => 'Answer', :conditions => 'accepted_at IS NOT NULL'
  has_many :answers

  validates :title, :presence => true
  validates :content, :presence => true

  def answerable?
    self.accepted_answer.nil?
  end
end
