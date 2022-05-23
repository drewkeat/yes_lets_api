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
