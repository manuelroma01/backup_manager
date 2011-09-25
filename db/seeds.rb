# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts 'Usuario admin'
puts '--------------------------------------'
user = User.create!(
  :username => 'root',
  :name => '',
  :surnames => '',
  :email => 'admin@test.com',
  :password => 'porfadmin',
  :password_confirmation => 'porfadmin'
)
puts 'Creado: ' << user.username

puts 'Usuarios seed'
puts '--------------------------------------'
user = User.create!(
  :username => 'seeduser',
  :name => 'Perich',
  :surnames => 'Van Der Palots',
  :email => 'seeduser@test.com',
  :password => 'porfaplis',
  :password_confirmation => 'porfaplis'
)
puts 'Creado: ' << user.username
