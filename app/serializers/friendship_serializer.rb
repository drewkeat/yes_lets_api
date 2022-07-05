class FriendshipSerializer
  include JSONAPI::Serializer
  attributes :id, :status
  belongs_to :user
  belongs_to :friend, serializer: :user
end
