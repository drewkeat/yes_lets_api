class Availability < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :user
  scope :matches, ->(avail) {where('id != ? and availabilities.start < ? and availabilities.end > ?', avail.id, avail.end, avail.start)}
  scope :future, -> { where('start > ?', Time.now)}
  validates_with AvailabilityValidator

  def match?(availability)
    availability.start.between?(self.start, self.end)
  end
end