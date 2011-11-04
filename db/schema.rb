# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111104163944) do

  create_table "equipments", :force => true do |t|
    t.string   "tag",             :limit => 10, :null => false
    t.string   "equipment_type",  :limit => 15, :null => false
    t.string   "equipment_model", :limit => 30
    t.string   "ip_address",      :limit => 15, :null => false
    t.string   "mac_address",     :limit => 17, :null => false
    t.string   "location",        :limit => 10
    t.string   "user",            :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "equipments", ["tag"], :name => "index_equipments_on_tag"
  add_index "equipments", ["user"], :name => "index_equipments_on_user"

  create_table "reserves", :force => true do |t|
    t.integer  "room_id",                      :null => false
    t.integer  "user_id",                      :null => false
    t.date     "reserve_start",                :null => false
    t.date     "reserve_end",                  :null => false
    t.string   "reason",        :limit => 100, :null => false
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",       :limit => 15, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", :force => true do |t|
    t.string   "name",       :limit => 20, :null => false
    t.string   "location",   :limit => 30
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",               :limit => 15,                  :null => false
    t.string   "name",                   :limit => 30
    t.string   "surnames",               :limit => 50
    t.string   "email",                                 :default => "", :null => false
    t.integer  "role_id",                                               :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
