class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :photo, index: true, foreign_key: true
     t.references :user, index: true, foreign_key: true

           t.timestamps null: false
    end
     add_index :likes, [:photo_id, :user_id], unique: true
  end
end
