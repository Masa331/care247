class ChangeToStatusFlag < ActiveRecord::Migration
  def up
  	change_column :requests, :status_flag, :integer
  end

  def down
  	change_column :requests, :status_flag, :string
  end
end
