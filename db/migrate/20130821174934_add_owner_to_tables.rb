class AddOwnerToTables < ActiveRecord::Migration
  def up
  	add_column :requests, :user_id, :string
  	add_column :parts, :user_id, :string
  end

  def down
  	remove_column :requests, :user_id, :string
  	remove_column :parts, :user_id, :string
  end
end
