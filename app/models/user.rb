class User < ApplicationRecord
  has_many :friendships
  has_many :pending_friendships, -> {where(confirmed: nil)}, class_name: "Friendship"
  has_many :friend_invites, -> {where(confirmed: nil)}, class_name: "Friendship", foreign_key: :friend
  has_many :confirmed_friendships, -> {where(confirmed: true)}, class_name: "Friendship"
  has_many :pending_friends, through: :pending_friendships, source: :friend
  has_many :friends, through: :friendships, source: :friend
  before_save :normalize_names

  def full_name
    self.first + " " + self.last
  end

  def friend(user)
    self.friendships.build(friend_id: user.id)
    self.save
  end

  def confirm_friend(friendship)
    friendship.update(confirmed: true)
    self.friendships.build(friend_id: friendship.user_id, confirmed: true)
    self.save
  end
  private

  def normalize_names
    self.first = self.first.downcase.capitalize
    self.last = self.last.downcase.capitalize
  end
end