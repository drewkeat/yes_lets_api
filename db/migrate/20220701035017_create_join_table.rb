class CreateJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :friendships, :users do |t|
      t.index [:friendship_id, :user_id]
      t.index [:user_id, :friendship_id]
    end
  end
end
