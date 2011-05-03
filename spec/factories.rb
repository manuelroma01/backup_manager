require 'factory_girl'

Factory.define :user do |u|
  u.sequence(:username) { |n| "testuser#{n}" }
  u.sequence(:email) { |n| "user#{n}@test.com" }
  u.password 'porfaplis'
end

Factory.define :workstation do |ws|
  ws.tag 'www.google.com'
  ws.ip_address '209.85.146.104'
  ws.mac_address '20:cf:30:e8:4b:4c'
end
