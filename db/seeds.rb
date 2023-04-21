# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#<Doorkeeper::Application id: 1, name: "Web client", uid: "_-hZvOODdpQBxngeH4X6RIj8u5eScPkIQF-smiELjxQ", secret: [FILTERED], redirect_uri: "", scopes: "", confidential: true, created_at: "2023-03-30 07:10:38.659256000 +0000", updated_at: "2023-03-30 07:10:38.659256000 +0000"> 
 

if Doorkeeper::Application.count.zero?
    Doorkeeper::Application.create(name: "Web client", redirect_uri: "", scopes: "")
end

Category.create(name: "Business")
Category.create(name: "Education")
Category.create(name: "Technology")
Category.create(name: "Entertainment")
Category.create(name: "Sports")

AdminUser.create!(email: 'admin@gmail.com', password: '12345678', password_confirmation: '12345678') if Rails.env.development?