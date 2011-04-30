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
