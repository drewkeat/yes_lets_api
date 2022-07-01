class Friendship < ApplicationRecord
  has_and_belongs_to_many :users
  scope :pending, -> {where(status: 'pending')}
  scope :confirmed, -> {where(status: 'confirmed')}
  scope :rejected, ->{where(status: 'rejected')}
  
  def confirm
    self.update(status: "confirmed")
  end

  def reject
    self.update(status: "rejected")
  end
end