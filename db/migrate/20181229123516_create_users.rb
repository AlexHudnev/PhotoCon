class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :access_token, null: false
      t.string :uid, null: false
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :image_url
      t.string :url

      t.timestamps null: false
    end
    add_index :users, :access_token
    add_index :users, :uid
    add_index :users, [:access_token, :uid], unique: true
  end
end
