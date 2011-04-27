require 'factory_girl'

Factory.define :user do |u|
  u.sequence(:username) { |n| "testuser#{n}" }
  u.sequence(:email) { |n| "user#{n}@test.com" }
  u.password 'porfaplis'
end

