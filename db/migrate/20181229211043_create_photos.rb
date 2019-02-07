class CreatePhotos < ActiveRecord::Migration[5.2]

  def change
    create_table :photos do |t|
      t.string :photo_name
      t.string :photography
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :photos, [:user_id, :created_at]
  end
end
