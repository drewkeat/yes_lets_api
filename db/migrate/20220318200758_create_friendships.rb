class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.string :status, default: 'pending'
      t.integer :user_id
      t.integer :friend_id

      t.timestamps
    end
  end
end
