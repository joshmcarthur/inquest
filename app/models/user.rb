class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include Gravtastic

  attr_accessor :login
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  validates :username, :presence => true, :uniqueness => true

  has_many :questions
  has_many :answers
  has_many :votes
  has_many :comments
  has_many :notification_rules, :class_name => 'Disclosure::Rule', :foreign_key => :owner_id
  has_gravatar :size => '80', :secure => false


  # Public: Determine whether this user has voted on a given object before.
  #
  # This method examines the collection of votes associated with this user,
  # returning true if the collection includes a vote on the object, and false if not.
  #
  # voteable - The voteable object (currently either question or answer) that should
  # be checked for in the votes collection
  # direction - The direction to scope to, or either up or down if nil
  # 
  # Returns true if the voteable exists in the collection of votes, and false if not
  def voted_on?(voteable, direction = ['up', 'down'])
    !self.votes.where(:voteable_id => voteable.id, :voteable_type => voteable.class.name).where(direction.nil? ? '1=1' : {:direction => direction}).count.zero?
  end
  
  # Public: Find the user record based on conditions passed to us by a devise controller.
  #
  # This method overrides a devise method to find the user record when logging in or resetting
  # password. This method is overridden because we need to find the user by username OR email.
  # This is done by querying on a virtual attribute named 'login'.
  #
  # conditions - The conditions passed to us by a devise controller - a hash of keys (attribute mames)
  # and values (user-entered values)
  #
  # Returns the found user, or nil
  def self.find_for_database_authentication(conditions)
    where('email = ? OR username = ?', conditions[:login], conditions[:login]).first
  end
end
