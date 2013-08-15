class ChangeToUserId < ActiveRecord::Migration
  def up
  	change_column :desks, :user_id, :integer, null: false
  end

  def down
  	change_column :desks, :user_id, :integer, null: true
  end
end
