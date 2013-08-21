class AddDeskIdToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :desk_id, :string
  end
end
