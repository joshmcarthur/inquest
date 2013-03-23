class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include Gravtastic

  attr_accessor :login
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  has_many :questions
  has_many :answers
  has_gravatar :size => '80', :secure => false


  def self.find_for_database_authentication(conditions)
    where('email = ? OR username = ?', conditions[:login], conditions[:login]).first
  end
end
