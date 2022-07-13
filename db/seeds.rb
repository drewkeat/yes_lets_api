# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_user(num)
  attributes = {
    first: "dummy",
    last: (num + 1).humanize,
    password: "pass"
  }
  attributes[:email] = attributes[:first] + "_" + attributes[:last] + "@email.com"
  User.create(attributes)
end

def create_availability(user)
  user.availabilities.build(start: Time.now)
end

3.times{|i| create_user(i)}

u1 = User.first; u2 =  User.find(2); u3 = User.last

u1.friend(u2)
u2.confirm_friend(u1)
u2.friend(u3)
u3.friend(u1)
u1.confirm_friend(u3)

def create_availability(user)
  future = (rand.round == 1)
  if future
    start_day = (Time.now + rand(1..20).days).noon
    later = (rand.round == 1)
    later ? start_time = start_day + rand(1..4).hours : start_time = start_day - rand(1..4).hours
  else 
    start_day = (Time.now - rand(1..20).days).noon
    later = (rand.round == 1)
    later ? start_time = start_day + rand(1..4).hours : start_time = start_day - rand(1..4).hours
  end
  end_time = start_time + rand(1..3).hours
  user.availabilities.build(start: start_time, end: end_time)
  user.save
end

User.all.each do |user|
  15.times{create_availability(user)}
end

def generate_random_hangtime(user)
  availability_user1 = user.possible_hangtimes.map(&:keys).flatten.sample
  availability_user2 = !!availability_user1 && user.possible_hangtimes.select{|friend_hash| friend_hash.keys.include?(availability_user1)}.sample[availability_user1].sample
  !!availability_user1 && !!availability_user2 && hangtime = Hangtime.create(Hangtime.match_up(availability_user1, availability_user2))
  !!hangtime && user.hangtimes.push << hangtime
  !!hangtime && Availability.find(availability_user2).user.hangtimes.push << hangtime
end

User.all.each do |user|
  generate_random_hangtime(user)
end
