class CreateEquipments < ActiveRecord::Migration
  def self.up
    create_table :equipments do |t|
      t.string :tag, :limit => 10, :null => false, :unique => true
      t.string :equipment_type, :limit => 15, :null => false
      t.string :equipment_model, :limit => 30
      t.string :ip_address, :limit => 15, :null => false, :unique => true
      t.string :mac_address, :limit => 17, :null => false, :unique => true
      t.string :location, :limit => 10
      t.string :user, :limit => 20

      t.timestamps
    end
    
    add_index :equipments, :tag
    add_index :equipments, :user
  end

  def self.down
    drop_table :equipments
  end
end
