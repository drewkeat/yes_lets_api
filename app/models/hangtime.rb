class Hangtime < ApplicationRecord
  has_and_belongs_to_many :users

  def self.match_up(availabilityID_1, availabilityID_2)
    availability_1 = Availability.find(availabilityID_1)
    availability_2 = Availability.find(availabilityID_2)
    start_time = [availability_1.start, availability_2.start].max
    end_time = [availability_1.end, availability_2.end].min
    
    {start: start_time, end: end_time}
  end
end


def generate_random_hangtime(user)
  availability_user1 = user.possible_hangtimes.map(&:keys).flatten.sample
  availability_user2 = user.possible_hangtimes.select{|friend_hash| friend_hash.keys.include?(availability_user1)}.sample[availability_user1].sample
  hangtime = Hangtime.create(Hangtime.match_up(availability_user1, availability_user2))
  user.hangtimes.push << hangtime
  Availability.find(availability_user2).user.hangtimes.push << hangtime
end
