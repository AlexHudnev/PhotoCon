# frozen_string_literal: true

ActiveAdmin.register User do
  index do
    selectable_column
    column :first_name
    column :last_name
    column :email
    column :created_at
    actions
  end
  show do
    attributes_table do
      row :image do |ad|
        image_tag ad.image_url
      end
      row :access_token
      row :uid
      row :first_name
      row :last_name
      row :email
      row :created_at
      row :updated_at
      row :id
    end
    active_admin_comments
  end
end
