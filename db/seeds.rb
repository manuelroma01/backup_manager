# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Vaciar datos actuales
Role.delete_all
User.delete_all
Room.delete_all
puts '-------------------------------------'
puts 'Seeds reseteados'
puts '-------------------------------------'

puts ''

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
  :name => 'root',
  :surnames => '',
  :email => 'admin@test.com',
  :role_id => roleroot.id,
  :password => 'porfadmin',
  :password_confirmation => 'porfadmin'
)
puts "+ #{user.username} - #{user.role.name}"
puts '-------------------------------------'

puts ''

# Rooms
puts '-------------------------------------'
puts 'Rooms'
room_johnsnow = Room.create!(
  :name => 'John Snow',
  :location => 'Ground floor',
  :comment => 'Sala John Snow'
)
puts "+ #{room_johnsnow.name}"

room_other_1 = Room.create!(
  :name => 'Other room place 1',
  :location => 'Ground floor',
  :comment => 'Sala X puesto 1'
)
puts "+ #{room_other_1.name}"

room_other_2 = Room.create!(
  :name => 'Other room place 2',
  :location => 'Ground floor',
  :comment => 'Sala X puesto 2'
)
puts "+ #{room_other_2.name}"

room_other_3 = Room.create!(
  :name => 'Other room place 3',
  :location => 'Ground floor',
  :comment => 'Sala X puesto 3'
)
puts "+ #{room_other_3.name}"

puts '-------------------------------------'


