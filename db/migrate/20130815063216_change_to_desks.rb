class ChangeToDesks < ActiveRecord::Migration
  def up
  	change_column :desks, :resolved_requests, :integer, default: 0
  	change_column :desks, :unresolved_requests, :integer, default: 0
  end

  def down
  	change_column :desks, :resolved_requests, :integer, default: nil
  	change_column :desks, :resolved_requests, :integer, default: nil
  end
end
