class RenameWorkstationsToEquipments < ActiveRecord::Migration
  def self.up
    rename_table :workstations, :equipments
  end

  def self.down
    rename_table :equipments, :workstations
  end
end



