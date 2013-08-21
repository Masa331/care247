class ChangeToRequestTable < ActiveRecord::Migration
  def up
  	remove_column :requests, :request_id
  	add_column :requests, :request_id, :string
  end
  def down
  	remove_column :requests, :request_id
  	add_column :requests, :request_id, :integer
  end
end
