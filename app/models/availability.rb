class Availability < ApplicationRecord
  belongs_to :user
  scope :matches, ->(avail) {where('id != ? and availabilities.start < ? and availabilities.end > ?', avail.id, avail.end, avail.start)}
  scope :future, -> { where('start > ?', Time.now)}

  def match?(availability)
    availability.start.between?(self.start, self.end)
  end
end