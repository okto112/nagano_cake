# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'toshi.oka.0602@gmail.com',
  password: 'asfghj'
)

Genre.create!(
  id: 21,
  name: 'cake',
)

Item.create!(
  name: 'cheese cake',
  introduction: 'cheese',
  price: 1220,
  genre_id: 21,
  is_active: true
)
