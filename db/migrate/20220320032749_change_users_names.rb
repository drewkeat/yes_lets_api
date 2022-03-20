class ChangeUsersNames < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :first, :first
    rename_column :users, :last, :last
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
