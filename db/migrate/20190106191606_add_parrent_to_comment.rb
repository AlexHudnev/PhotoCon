class AddParrentToComment < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :parent_comment_id, :integer , index: true, foreign_key: true
  end

end
