# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_user
  attributes = {
    first: Faker::Name.first_name,
    last: Faker::Name.last_name,
    password: "pass"
  }
  attributes[:email] = attributes[:first] + "_" + attributes[:last] + "@email.com"
  User.create(attributes)
end

def create_availability(user)
  user.availabilities.build(start: Time.now)
end