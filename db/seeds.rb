# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.delete_all
categories = [
    "Furniture",
    "Books & Audible",
    "Video Games",
    "Music, Movies & TV Shows",
    "Electronics, Computers & Office",
    "Tools",
    "Grocery & Whole Foods",
    "Health & Beauty",
    "Toys",
    "Clothing, Shoes & Jewelry",
    "Handmade",
    "Sports & Outdoors",
    "Automotive"
]

categories.each do | category |
    Category.create( name: category)
end

auser = User.create(email: 'admin@lendto.com', password: '123456', password_confirmation: '123456', admin: true)
auser.skip_confirmation!
auser.profile.first_name = "Admin"
auser.profile.save!