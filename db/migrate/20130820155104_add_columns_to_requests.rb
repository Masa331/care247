class AddColumnsToRequests < ActiveRecord::Migration

   def up
   	add_column :requests, :status_flag, :integer
   	add_column :requests, :subject, :string
   	add_column :requests, :body, :string
   	add_column :requests, :to, :string
   	add_column :requests, :from, :string

   	change_column :requests, :request_id, :string, null: false
   	change_column :requests, :desk_id, :string, null: false

   	add_index :requests, :desk_id
   	add_index :requests, :request_id
  end

  def down
   	remove_column :requests, :status_flag
   	remove_column :requests, :subject
   	remove_column :requests, :body
   	remove_column :requests, :to
   	remove_column :requests, :from

   	change_column :requests, :request_id, :string, null: true
   	change_column :requests, :desk_id, :string, null: true
  
   	remove_index :requests, :desk_id
   	remove_index :requests, :request_id
  end

end
