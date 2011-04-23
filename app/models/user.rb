# == Schema Information
# Schema version: 20110411215645
#
# Table name: users
#
#  id                :integer         not null, primary key
#  username          :string(20)      not null
#  email             :string(50)      not null
#  crypted_password  :string(255)
#  password_salt     :string(255)
#  persistence_token :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class User < ActiveRecord::Base
  acts_as_authentic
  
  attr_accessible :username, :email
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :username, :presence => true,
    :length => { :maximum => 50 }
  validates :email, :presence => true,
    :format => { :with => email_regex}
end
