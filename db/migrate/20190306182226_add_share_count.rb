class AddShareCount < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :share, :integer, default: 0, null: false
  end
end
