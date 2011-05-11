require 'factory_girl'

Factory.define :user do |u|
  u.sequence(:username) { |n| "testuser#{n}" }
  u.sequence(:email) { |n| "user#{n}@test.com" }
  u.password 'porfaplis'
end

Factory.define :workstation do |ws|
  ws.sequence(:tag) { |n| "tag#{n}" }
  ws.sequence(:ip_address) { |n| "#{(rand(220)+10)}.#{(rand(220)+10)}.#{(rand(220)+10)}.#{(rand(220)+10)}" }
  ws.sequence(:mac_address) { |n| "#{(rand(230)+20).to_s(16)}-#{(rand(230)+20).to_s(16)}-#{(rand(230)+20).to_s(16)}-#{(rand(230)+20).to_s(16)}-#{(rand(230)+20).to_s(16)}-#{(rand(230)+20).to_s(16)}" }
end
