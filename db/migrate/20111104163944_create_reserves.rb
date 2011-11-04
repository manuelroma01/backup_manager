class CreateReserves < ActiveRecord::Migration
  def self.up
    create_table :reserves do |t|
      t.integer :room_id, :null => false
      t.integer :user_id, :null => false
      t.date :reserve_start, :null => false
      t.date :reserve_end, :null => false
      t.string :reason, :limit => 100, :null => false
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :reserves
  end
end
