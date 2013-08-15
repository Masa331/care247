class AddNumbersToDesk < ActiveRecord::Migration
  def change
  	add_column :desks, :resolved_requests, :integer
  	add_column :desks, :unresolved_requests, :integer
  end
end
