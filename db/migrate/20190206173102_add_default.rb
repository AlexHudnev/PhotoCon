class AddDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_null :photos, :comment_count, false
    change_column_default :photos, :comment_count, 0
    change_column_null :photos, :rating, false
    change_column_default :photos, :rating, 0
  end
end
