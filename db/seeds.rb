# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
   email: 'sotaroogawa0203@gmail.com',
   password: '120203'
)
Genre.create!(
  name: "ケーキ"
)

Item.create!(
  genre_id: 1,
  name: "ケーキ",
  image: File.open('./app/assets/images/cake.jpg'),
  introduction: "テスト",
  price: 10000,
  is_active: true
)
