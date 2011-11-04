class Reserve < ActiveRecord::Base
  # relaciones
  belongs_to :user
  belongs_to :room
end
