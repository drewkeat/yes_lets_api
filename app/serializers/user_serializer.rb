class UserSerializer
  include JSONAPI::Serializer
  attributes :full_name, :email, :phone_number
  has_many :friends, serializer: :user
  has_many :pending_friends, serializer: :user
  has_many :friend_invites, serializer: :user
  has_many :availabilities
  has_many :hangtimes
  has_many :friendships
  has_many :pending_friendships, serializer: :friendship
  has_many :friendship_invites, serializer: :friendship
end
