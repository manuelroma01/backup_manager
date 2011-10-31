class Role < ActiveRecord::Base
  # acceso
  attr_accessible :name

  # validaciones
  validates :name,
    :presence => true,
    :unique => true
  
  # relaciones
  has_many :users
end
# == Schema Information
#
# Table name: roles
#
#  id         :integer         not null, primary key
#  name       :string(15)      not null
#  created_at :datetime
#  updated_at :datetime
#

