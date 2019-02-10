class AddModerationUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :moderator, :boolean, default: false
  end
end
