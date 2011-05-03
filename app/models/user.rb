# == Schema Information
# Schema version: 20110423232254
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  failed_attempts        :integer         default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string(255)
#

class User < ActiveRecord::Base
  # modulos devise
  devise :database_authenticatable, :timeoutable, :recoverable, :trackable, :validatable, :lockable

  # accesible
  attr_accessible :username, :email, :password, :password_confirmation
  
  # validaciones
  # devise include validaciones para email y password
  # ver ~/config/initializers/devise.rb
  validates :username, :presence => true, :uniqueness => true,
    :length => { :maximum => 30 }
end
