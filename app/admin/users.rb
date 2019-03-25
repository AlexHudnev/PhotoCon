# frozen_string_literal: true

ActiveAdmin.register User do

  config.xls_builder.delete_columns :created_at, :updated_at, :moderator,
                                    :access_token
  permit_params :first_name, :last_name, :image_url, :email, :moderator,
                :access_token, :uid, :partner
  scope I18n.t(:all), :all
  scope(I18n.t(:moderator)) { User.where(moderator: true) }

  index do
    selectable_column
    column :first_name
    column :last_name
    column :email
    column :created_at
    column :ban do |pg|
      columns do
        if pg.ban
          column do
            link_to I18n.t(:reban), reban_admin_user_path(pg), class: 'button2'
          end
        else unless pg.moderator
             column do
               link_to I18n.t(:ban), ban_admin_user_path(pg), class: 'button1',
                                                              title: I18n.t(:baninf)
             end
          end
        end
      end
    end
    actions defaults: false, dropdown: true do |pg|
      item  link_to I18n.t(:show), admin_user_path(pg)
      unless Photo.where(user_id: pg.id).size.positive?
        item link_to I18n.t(:delete), delete_admin_user_path(pg)
      end
      item link_to I18n.t(:edit), edit_admin_user_path(pg)
    end
  end
  show do
    photos = Photo.where(user_id: params[:id])
    attributes_table do
      row :image do |ad|
        image_tag ad.image_url
      end
      row :shared do
        photos.inject(0) { |ac, el| ac + el.share }
      end
      row :ban
      row :id
      row :moderator
      row :partner
      row :first_name
      row :last_name
      row :access_token
      row :uid
      row :url
      row :email
      row :authenticity_token
      row :created_at
      row :updated_at
    end
    phots = Kaminari.paginate_array(photos).page(params[:page]).per(9)
    render '/admin/gal', photos: phots
  end

  form do |f|
    if f.object.moderator?
      f.inputs do
        f.input :image_url
        f.input :first_name
        f.input :last_name
        f.input :email
        f.input :access_token
        f.input :uid
      end
    end
    f.input :moderator
    f.input :partner
    f.actions
  end

  member_action :ban do
    user = User.find_by(id: params[:id])
    user.ban = true
    user.save
    Redis.current.set(user.uid, 'Ban')
    BanWorker.perform_in(20.minutes, params[:id])
    redirect_to admin_users_path
  end
  member_action :reban do
    user = User.find_by(id: params[:id])
    user.ban = false
    Redis.current.del(user.uid)
    user.save
    redirect_to admin_users_path
  end
  member_action :delete do
    user = User.find_by(id: params[:id])
    user.destroy
    redirect_to admin_users_path
  end
end
