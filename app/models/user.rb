class User < ApplicationRecord
  has_and_belongs_to_many :friendships, ->{where(status: 'confirmed')}
  has_and_belongs_to_many :pending_friendships, ->{where(status: 'pending')}, class_name:"Friendship"
  has_and_belongs_to_many :friendship_invites, ->(user) {where(status: 'pending', friend_id: user.id)}, class_name: "Friendship"
  has_many :friends, ->(user){where('users.id != ?', user.id)}, through: :friendships, source: :users
  has_many :pending_friends, ->(user){where('users.id != ? AND friend_id != ?', user.id, user.id)}, through: :pending_friendships, source: :users
  has_many :friend_invites, ->(user){where('users.id != ? AND friend_id = ?', user.id, user.id)}, through: :pending_friendships, source: :users
  has_many :availabilities
  has_and_belongs_to_many :hangtimes
  has_secure_password
  before_save :normalize_attributes
  validates_presence_of :email, on: :create, message: "can't be blank"
  scope :findBySubstring, ->(substring) {where("first ILIKE ? OR last ILIKE ?", "%#{substring}%", "%#{substring}%")}

  def full_name
    self.first + " " + self.last
  end

  def friend(user)
    friendship = Friendship.create(user_id: self.id, friend_id: user.id)
    user.friendships << friendship
    user.save
    self.friendships << friendship
    self.save
  end

  def confirm_friend(friend)
    friendship = self.friendship_invites.select{|user| user.id = friend.id}.first
    friendship.update(status: "confirmed")
    friendship.save
  end

  def options_with(friend)
    times = self.availabilities.map do |availability|
      [availability.id, friend.availabilities.matches(availability).map(&:id)]
    end
    times = times.to_h
    times.select{|k,v| !v.empty?}
  end

  def possible_hangtimes
    self.friends.map{|friend| options_with(friend)}
  end

  private

  def normalize_attributes
    self.first = self.first.downcase.capitalize
    self.last = self.last.downcase.capitalize
    # self.email = self.email.downcase
    #TODO: normalize phone number
  end
end