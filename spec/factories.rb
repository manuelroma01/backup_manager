require 'factory_girl'

Factory.define :user do |u|
  u.username 'testuser'
  u.email 'user@test.com'
  u.password 'porfaaa'
end
