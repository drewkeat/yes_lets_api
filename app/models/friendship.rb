class Friendship < ApplicationRecord
  include ActiveModel::Validations
  has_and_belongs_to_many :users
  scope :pending, -> {where(status: 'pending')}
  scope :confirmed, -> {where(status: 'confirmed')}
  scope :rejected, ->{where(status: 'rejected')}
  scope :involves_users, ->(user1, user2){where("(user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?)", user1, user2, user2, user1)}
  validates_with FriendshipValidator, on: :create
  
  def confirm
    self.update(status: "confirmed")
  end

  def reject
    self.update(status: "rejected")
  end
end