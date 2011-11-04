class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string :username, :limit => 15, :null => false
      t.string :name, :limit => 30
      t.string :surnames, :limit => 50
      t.string :email, :limit => 15, :null => false
      t.integer :role_id, :null => false  # fk
      
      t.database_authenticatable :null => false
      t.recoverable
      t.trackable
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :users
  end
end
