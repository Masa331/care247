class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :request_id, null: false
      t.text :body
      t.index :request_id

      t.timestamps
    end
  end
end
