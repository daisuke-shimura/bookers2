# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!([
  {
    name: "大谷英美里",
    email: "a@exsample.com",
    password: "aiueoa"
  },
  {
    name: "齋藤樹愛羅",
    email: "d@exsample.com",
    password: "aiueoa"
  },
  {
    name: "佐々木舞香",
    email: "e@exsample.com",
    password: "aiueoa"
  },
  {
    name: "高松瞳",
    email: "f@exsample.com",
    password: "aiueoa"
  },
  {
    name: "野口衣織",
    email: "h@exsample.com",
    password: "aiueoa"
  }
])