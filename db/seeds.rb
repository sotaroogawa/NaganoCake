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
Genre.create!(
  name: "パンケーキ"
)
Genre.create!(
  name: "クッキー"
)

Item.create!(
  genre_id: 1,
  name: "ストロベリーケーキ",
  image: File.open('./app/assets/images/Strawberrycake.jpg'),
  introduction: "テスト",
  price: 1000,
  is_active: true
)
Item.create!(
  genre_id: 2,
  name: "パンケーキ",
  image: File.open('./app/assets/images/pancake.jpg'),
  introduction: "テスト",
  price: 1500,
  is_active: true
)
Item.create!(
  genre_id: 3,
  name: "クッキー",
  image: File.open('./app/assets/images/cookie.jpg'),
  introduction: "テスト",
  price: 2000,
  is_active: true
)