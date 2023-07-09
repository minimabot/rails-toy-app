# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

100.times do
  User.create([
                {
                  last_name: Faker::Name.last_name,
                  first_name: Faker::Name.first_name,
                  nickname: Faker::Internet.username(specifier: 3..8),
                  email: Faker::Internet.email,
                  password: Faker::Internet.password,
                  activated_at: Time.zone.now
                }
              ])
end
