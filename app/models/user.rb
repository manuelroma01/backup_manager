class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  # :rememberable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # :remember_me
  attr_accessible :username, :email, :password, :password_confirmation
  
  validates_presence_of :username
  validates_uniqueness_of :username, :email, :case_sensitive => false
end
