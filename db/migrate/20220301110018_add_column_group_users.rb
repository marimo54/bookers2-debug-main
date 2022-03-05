class AddColumnGroupUsers < ActiveRecord::Migration[6.1]
  def change
    add_index :group_users, :user_id, name: "index_group_users_on_user_id"
    add_index :group_users, [:user_id,:group_id],  name: "index_group_users_on_user_id_and_group_id", unique:true
    add_index :group_users, :group_id, name: "index_group_users_on_group_id"
  end
end
