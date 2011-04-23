class CreateWorkstations < ActiveRecord::Migration
  def self.up
    create_table :workstations do |t|
      t.string :tag, :limit => 10, :null => false, :unique => true
      t.string :ip_address, :limit => 15, :null => false, :unique => true
      t.string :mac_accress, :limit => 17, :null => false, :unique => true
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :workstations
  end
end
