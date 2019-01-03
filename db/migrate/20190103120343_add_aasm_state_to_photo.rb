class AddAasmStateToPhoto < ActiveRecord::Migration[5.2]
  def change
add_column :photos, :aasm_state, :string
  end
end
