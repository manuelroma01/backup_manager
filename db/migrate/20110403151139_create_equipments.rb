class CreateEquipments < ActiveRecord::Migration
  def self.up
    create_table :equipments do |t|
      t.string :tag, :limit => 10, :null => false, :unique => true
      t.string :ip_address, :limit => 15, :null => false, :unique => true
      t.string :mac_address, :limit => 17, :null => false, :unique => true
      t.integer :user_id

      t.timestamps
    end
    
    add_index :equipments, :tag
    add_index :equipments, :user_id
  end

  def self.down
    drop_table :equipments
  end
end
