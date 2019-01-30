class AddCommentCountToPhoto < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :comment_count, :integer, null: false, default: 0
  end
end
