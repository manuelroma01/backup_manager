class Room < ActiveRecord::Base
  # relaciones
  has_many :reserves
end
