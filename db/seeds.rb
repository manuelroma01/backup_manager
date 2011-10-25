# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts '-------------------------------------'
puts 'Roles'
roleroot = Role.create!(
  :name => 'root'
)
puts '+ ' << roleroot.name

roleuser = Role.create!(
  :name => 'user'
)
puts '+ ' << roleuser.name
puts '-------------------------------------'
puts ''
puts '-------------------------------------'
puts 'Usuarios'
user = User.create!(
  :username => 'root',
  :name => '',
  :surnames => '',
  :email => 'admin@test.com',
  :role => roleroot,
  :password => 'porfadmin',
  :password_confirmation => 'porfadmin'
)
puts "+ #{user.username} - #{user.role.name}"

user = User.create!(
  :username => 'seeduser',
  :name => 'Perich',
  :surnames => 'Van Der Palots',
  :email => 'seeduser@test.com',
  :role => roleuser,
  :password => 'porfaplis',
  :password_confirmation => 'porfaplis'
)
puts "+ #{user.username} - #{user.role.name}"
puts '-------------------------------------'

