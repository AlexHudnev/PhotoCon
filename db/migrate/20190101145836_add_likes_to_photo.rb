class AddLikesToPhoto < ActiveRecord::Migration[5.2]
  def change
     add_column :photos, :rating, :integer, null: false, default: 0
  end
end
