class AddLikesToPhoto < ActiveRecord::Migration[5.2]
  def change
     add_column :photos, :rating, :integer
  end
end
