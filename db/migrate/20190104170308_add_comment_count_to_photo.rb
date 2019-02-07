class AddCommentCountToPhoto < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :comment_count, :integer
  end
end
