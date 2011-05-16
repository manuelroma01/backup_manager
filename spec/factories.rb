require 'factory_girl'

# user random
Factory.define :user do |u|
  u.sequence(:username) { |n| "testuser#{n}" }
  u.sequence(:email) { |n| "user#{n}@test.com" }
  u.password 'porfaplis'
end

# workstation random
Factory.define :workstation do |ws|
  ws.sequence(:tag) { |n| "tag#{n}" }
  ws.sequence(:ip_address) { |n| "#{(rand(220)+10)}.#{(rand(220)+10)}.#{(rand(220)+10)}.#{(rand(220)+10)}" }
  ws.sequence(:mac_address) { |n| "#{(rand(230)+20).to_s(16)}-#{(rand(230)+20).to_s(16)}-#{(rand(230)+20).to_s(16)}-#{(rand(230)+20).to_s(16)}-#{(rand(230)+20).to_s(16)}-#{(rand(230)+20).to_s(16)}" }
end

# workstations
Factory.define :workstation_local, :parent => :workstation do |ws|
  ws.tag 'localhost'
  ws.ip_address '127.0.0.1'
end

Factory.define :workstation_google, :parent => :workstation do |ws|
  ws.tag "www.google.com"
  ws.ip_address "209.85.147.103"
end

Factory.define :workstation_creal, :parent => :workstation do |ws|
  ws.tag "www.creal.cat"
  ws.ip_address "193.144.6.2"
end

Factory.define :workstation_false, :parent => :workstation do |ws|
  ws.tag 'fake_ws'
  ws.ip_address '125.5.5.1'
end

