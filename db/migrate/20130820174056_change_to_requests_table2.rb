class ChangeToRequestsTable2 < ActiveRecord::Migration
    def up
  	change_column :requests, :subject, :string, null: false
   	change_column :requests, :to, :string, null: false
   	change_column :requests, :from, :string, null: false
   	change_column :requests, :status_flag, :string, null: false
  end
  
  def down
  	change_column :requests, :subject, :string, null: true
   	change_column :requests, :to, :string, null: true
   	change_column :requests, :from, :string, null: true
   	change_column :requests, :status_flag, :string, null: true
  end
end
