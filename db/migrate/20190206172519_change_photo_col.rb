class ChangePhotoCol < ActiveRecord::Migration[5.2]
  def change
  rename_column :photos, :photo_name, :name
  end
end
