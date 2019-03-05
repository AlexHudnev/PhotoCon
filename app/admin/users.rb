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
    column :ban do |pg|
      link_to :ban, ban_admin_user_path(pg)
    end
    actions
  end
  show do
    photos = Photo.where(user_id: params[:id])
    attributes_table do
      row :image do |ad|
        image_tag ad.image_url
      end
      row :ban
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
    end
    phots = Kaminari.paginate_array(photos).page(params[:page]).per(9)
    render '/admin/gal', photos: phots
  end

  member_action :ban do
    user = User.find_by(id: params[:id])
    user.ban = true
    user.save
    BanWorker.perform_in(20.minutes, params[:id])
    redirect_to admin_users_path
  end
end
