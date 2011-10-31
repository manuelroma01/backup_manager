# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Vaciar seed data
Role.delete_all
User.delete_all

# Roles
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

# Usuarios
puts '-------------------------------------'
puts 'Usuarios'
user = User.create!(
  :username => 'root',
  :name => '',
  :surnames => '',
  :email => 'admin@test.com',
  :role_id => roleroot.id,
  :password => 'porfadmin',
  :password_confirmation => 'porfadmin'
)
puts "+ #{user.username} - #{user.role.name}"

user = User.create!(
  :username => 'seeduser',
  :name => 'Perich',
  :surnames => 'Van Der Palots',
  :email => 'seeduser@test.com',
  :role_id => roleuser.id,
  :password => 'porfaplis',
  :password_confirmation => 'porfaplis'
)
puts "+ #{user.username} - #{user.role.name}"
puts '-------------------------------------'

