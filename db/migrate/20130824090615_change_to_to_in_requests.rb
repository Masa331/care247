class ChangeToToInRequests < ActiveRecord::Migration
  def up
  	change_column :requests, :to, :text
  end
  def down
  	change_column :requests, :to, :string
  end
end
