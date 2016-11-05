# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

egg_count = [
  [ 0, 0 ]
]

egg_count.each do |total, user_eggs|
  Egg.create( total: total, user_eggs: user_eggs )
end
