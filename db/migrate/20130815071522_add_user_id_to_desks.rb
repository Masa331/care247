class AddUserIdToDesks < ActiveRecord::Migration
  def change
    add_column :desks, :user_id, :integer
    add_index :desks, :user_id
  end
end
