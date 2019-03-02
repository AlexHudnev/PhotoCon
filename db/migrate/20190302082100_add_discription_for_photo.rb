class AddDiscriptionForPhoto < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :description, :string, default: ''
  end
end
