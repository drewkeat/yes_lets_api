class FriendshipSerializer
  include JSONAPI::Serializer
  attributes :id, :confirmed
  belongs_to :user
  belongs_to :friend, serializer: :user
end
