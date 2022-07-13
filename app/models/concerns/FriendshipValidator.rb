class FriendshipValidator < ActiveModel::Validator
  def validate(friendship)
    u1 = friendship.user_id
    u2 = friendship.friend_id

    if Friendship.involves_users(u1,u2).any?
      friendship.errors.add :base, :invalid, message: "A friendship already exists between these two users."
    end
  end
end