ActiveAdmin.register User do
  index do
    selectable_column
    column :first_name
    column :last_name
    column :email
    column :created_at
    actions
  end
end
