class AddPartnerState < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :partner, :boolean, default: false
  end
end
