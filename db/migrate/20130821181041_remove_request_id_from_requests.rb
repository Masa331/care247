class RemoveRequestIdFromRequests < ActiveRecord::Migration
  def up
    remove_column :requests, :request_id, :string
  end

  def down
  	add_column :requests, :request_id, :string
  end
end
