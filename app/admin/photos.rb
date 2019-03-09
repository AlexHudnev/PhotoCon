# frozen_string_literal: true

require 'sidekiq/api'
require 'rubygems'
require 'zip'
ActiveAdmin.register Photo do
  config.xls_builder.delete_columns :created_at, :updated_at, :photography
  config.per_page = [5, 10, 50, 100]

  scope I18n.t(:all), :all
  scope I18n.t('active_admin.status_tag.approved'), :approved, group: :status
  scope I18n.t('active_admin.status_tag.banned'), :banned, group: :status
  scope I18n.t('active_admin.status_tag.moderated'), :moderated,  group: :status

  action_item :add, only: :index do
    link_to I18n.t(:dowload_all_photo), download_zip_path, metod: :get
  end
  controller do
    def destroy
      resource.delete!
      RemovePhotoWorker.perform_in(5.minutes, params[:id])
      redirect_to admin_photos_path
    end
  end

  batch_action I18n.t(:ban) do |ids|
    batch_action_collection.find(ids).each do |post|
      post.ban! :ban
    end
    redirect_to admin_photos_path
  end

  batch_action I18n.t(:approve) do |ids|
    batch_action_collection.find(ids).each do |post|
      post.approve! :approve
    end
    redirect_to admin_photos_path
  end

  batch_action :destroy do |ids|
    batch_action_collection.find(ids).each do |post|
      post.delete! :delete
      RemovePhotoWorker.perform_in(5.minutes, params[:id])
    end
    redirect_to admin_photos_path
  end

  index  do
    selectable_column
    column :name
    column :share
    column :photo do |pg|
      image_tag pg.photography.admin.url
    end
    state_column :aasm_state
    column :moderation do |pg|
      columns do
        if pg.aasm_state == 'moderated'
          column do
            link_to I18n.t(:approve), approve_admin_photo_path(pg)
          end
          column do
            link_to I18n.t(:ban), ban_admin_photo_path(pg)
          end
        elsif pg.aasm_state == 'approved'
          column do
            link_to I18n.t(:ban), ban_admin_photo_path(pg)
          end
        elsif pg.aasm_state == 'deleted'
          column do
            link_to I18n.t(:restore), restore_admin_photo_path(pg)
          end
        else
          column do
            link_to I18n.t(:approve), approve_admin_photo_path(pg)
          end
        end
      end
    end
    actions
  end

  show do
    attributes_table do
      photo = Photo.find_by(id: params[:id])
      row :photography do |ad|
        image_tag ad.photography.show.url
      end
      row :name
      row :description
      row :author, :user_id do
        link_to('Author', admin_user_path(photo.user_id))
      end
      row :rating
      row :created_at
      row :updated_at
      row :id
      row :aasm_state
    end
    coms = Kaminari.paginate_array(photo.comments).page(params[:page]).per(6)
    render '/admin/comments', comments: coms
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :aasm_state
    end
    f.actions
  end

  member_action :approve do
    photo = Photo.find_by(id: params[:id])
    resource.approve!
    UserMailer.state_change_email(photo, 'approve').deliver_now
    redirect_to admin_photos_path
  end

  member_action :ban do
    photo = Photo.find_by(id: params[:id])
    resource.ban!
    UserMailer.state_change_email(photo, 'ban').deliver_now
    RemovePhotoWorker.perform_in(20.minutes, params[:id])
    redirect_to admin_photos_path
  end

  member_action :restore do
    resource.restore!
    redirect_to admin_photos_path
  end
end
