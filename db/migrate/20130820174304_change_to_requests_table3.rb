class ChangeToRequestsTable3 < ActiveRecord::Migration
  def up
  	remove_column :requests, :body
  	add_column :requests, :body, :text
  end

  def down
  	remove_column :requests, :body
  	add_column :requests, :body, :string
  end
end
