class CreateJoinTableUsersHangtimes < ActiveRecord::Migration[6.1]
  def change
    create_join_table :users, :hangtimes do |t|
      t.index [:user_id, :hangtime_id]
      t.index [:hangtime_id, :user_id]
    end
  end
end
