class VariousChangesToTables < ActiveRecord::Migration
  def up
  	add_column :desks, :desks_mailbox, :string
    remove_column :requests, :body

  	add_index :desks, :desks_mailbox
  	add_index :requests, :request_id
  end

  def down
  	remove_column :desks, :desks_mailbox
    add_column :requests, :body, :text

  	remove_index :requests, :request_id
  	remove_index :desks, :desks_mailbox
  end
end
