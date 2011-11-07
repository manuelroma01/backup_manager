class Reserve < ActiveRecord::Base
  # relaciones
  belongs_to :user
  belongs_to :room

  # accesibilidad de atributos
  attr_accessible :room_id, :user_id, :reserve_start, :reserve_end, :reason, :comment
  
  # validaciones atributos
  validates :room_id, :presence => true
  validates :user_id, :presence => true
  validates :reserve_start, :presence => true
  validates :reserve_end, :presence => true
  validates :reason, :presence => true,
    :length => { :maximum => 100 }
end
