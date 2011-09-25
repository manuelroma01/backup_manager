require 'factory_girl'

# user random
Factory.define :user do |u|
  u.sequence(:username) { |n| "testuser#{n}" }
  u.sequence(:email) { |n| "user#{n}@test.com" }
  u.password 'porfaplis'
end

# equipment random
Factory.define :equipment do |e|
  e.sequence(:tag) { |n| "tag#{n}" }
  e.equipment_type 'server'
  e.equipment_model 'notifixis'
  e.sequence(:ip_address) { |n| "#{(rand(220)+10)}.#{(rand(220)+10)}.#{(rand(220)+10)}.#{(rand(220)+10)}" }
  e.sequence(:mac_address) { |n| "#{(rand(230)+20).to_s(16)}-#{(rand(230)+20).to_s(16)}-#{(rand(230)+20).to_s(16)}-#{(rand(230)+20).to_s(16)}-#{(rand(230)+20).to_s(16)}-#{(rand(230)+20).to_s(16)}" }
  e.location 'lapcalle'
  e.equipment_user 'robocop'
end

# equipments
Factory.define :equipment_local, :parent => :equipment do |e|
  e.tag 'localhost'
  e.ip_address '127.0.0.1'
end

Factory.define :equipment_google, :parent => :equipment do |e|
  e.tag "www.google.com"
  e.ip_address "209.85.147.103"
end

Factory.define :equipment_creal, :parent => :equipment do |e|
  e.tag "www.creal.cat"
  e.ip_address "193.144.6.2"
end

Factory.define :equipment_false, :parent => :equipment do |e|
  e.tag 'fake_equipment'
  e.ip_address '125.5.5.1'
end

