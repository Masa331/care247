class RemoveNameFromRequests < ActiveRecord::Migration
  def up
    remove_column :requests, :name
  end

  def down
  	add_column :requests, :name, :string
  end
end
