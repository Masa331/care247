class ChangeToIcField < ActiveRecord::Migration
	def up
		remove_column :users, :ic
		add_column :users, :ic, :string
	end

	def down
		remove_column :users, :ic
		add_column :users, :ic, :integer
	end
end
