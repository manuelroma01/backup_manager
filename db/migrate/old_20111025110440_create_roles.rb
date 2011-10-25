class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :type, :limit => 15, :null => false, :unique => true
      t.string :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end

