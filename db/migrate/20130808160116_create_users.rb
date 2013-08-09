class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :zip_code
      t.string :country
      t.integer :ic
      t.string :dic
      t.integer :phone
      t.string :email
      t.string :password_hash
      t.string :password_salt

      t.timestamps
    end
  end
end
