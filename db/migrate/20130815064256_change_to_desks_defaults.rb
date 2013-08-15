class ChangeToDesksDefaults < ActiveRecord::Migration
  def up
  	change_column :desks, :name, :string, null: false
  end

  def down
  	change_column :desks, :name, :string, null: true
  end
end
