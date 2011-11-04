class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.string :name, :limit => 20, :null => false
      t.string :location, :limit => 30
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
