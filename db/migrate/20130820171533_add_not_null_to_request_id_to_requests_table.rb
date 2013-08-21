class AddNotNullToRequestIdToRequestsTable < ActiveRecord::Migration
  def up
  	change_column :requests, :request_id, :string, null: false
  end
  
  def down
  	change_column :requests, :request_id, :string, null: true
  end
end
