class Room < ActiveRecord::Base
  # relaciones
  has_many :reserves
  
  # accesibilidad de atributos
  attr_accessible :name, :location, :comment
  
  # validaciones atributos
  validates :name, :presence => true,
    :length => { :maximum => 20 },
    :uniqueness => true
  validates :location, :presence => true,
    :length => { :maximum => 30 }
end
