# frozen_string_literal: true

ActiveAdmin.register User do
  config.xls_builder.delete_columns :created_at, :updated_at, :moderator,
                                    :access_token


  controller do
    def destroy
      resource.destroy unless Photo.where(user_id: params[:id]).size.positive?
    end
  end
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
      photos = Photo.where(user_id: params[:id])
      row :id
      row :moderator
      row :first_name
      row :last_name
      row :access_token
      row :uid
      row :url
      row :email
      row :created_at
      row :updated_at
      dropdown_menu I18n.t('active_admin.photos.photography') do
        photos.each do |photo|
          item photo.name, admin_photo_path(photo)
        end
      end
    end
    active_admin_comments
  end
end
