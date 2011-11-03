class User < ActiveRecord::Base
  # modulos devise
  devise :database_authenticatable, :timeoutable, :recoverable, :trackable, :validatable, :lockable

  # relaciones
  belongs_to :role

  # accesible
  attr_accessible :username, :name, :surnames, :email, :password, :password_confirmation, :role_id
  
  # validaciones
  # devise include validaciones para email y password
  # ver ~/config/initializers/devise.rb
  validates :username, :presence => true, :uniqueness => true,
    :length => { :maximum => 30 }
  validates :role_id, :presence => true
  
  # metodos publicos
  def get_role
    if self.role
      return self.role.name
    else
      return nil
    end
  end
  
  def role?(role)
    return !!self.role.name == role
  end
  
  def find_by_role(role_name)
    # por hacer
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  username               :string(15)
#  name                   :string(30)
#  surnames               :string(50)
#  email                  :string(255)     default(""), not null
#  role_id                :integer
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
#
