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
room_itaca = Room.create!(
  :name => 'Itaca',
  :location => 'Espai Rachel Carlson - Altell',
  :comment => 'Sala de reunions'
)
puts "+ #{room_itaca.name}"

room_johnsnow_pica = Room.create!(
  :name => 'John Snow Lab Pica',
  :location => 'Espai John Snow',
  :comment => 'Laboratori Pica'
)
puts "+ #{room_johnsnow_pica.name}"

room_johnsnow_cent = Room.create!(
  :name => 'John Snow Lab Cent',
  :location => 'Espai John Snow',
  :comment => 'Laboratori Centrifugadora'
)
puts "+ #{room_johnsnow_cent.name}"

room_johnsnow_altre = Room.create!(
  :name => 'John Snow Lab altre',
  :location => 'Espai John Snow',
  :comment => 'Laboratori altre'
)
puts "+ #{room_johnsnow_altre.name}"

room_johnsnow_visitants = Room.create!(
  :name => 'John Snow Visitants',
  :location => 'Espai John Snow',
  :comment => 'Sala Visitants'
)
puts "+ #{room_johnsnow_visitants.name}"

puts '-------------------------------------'


