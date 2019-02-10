# frozen_string_literal: true

require 'sidekiq/api'
ActiveAdmin.register Photo do
  index do
    selectable_column
    column :name
    column :photo do |pg|
      image_tag pg.photography.admin.url
    end
    state_column 'Current Status', :aasm_state
    column 'Moderation', :moderation do |pg|
      columns do
        if pg.aasm_state == 'moderated'
          column do
            link_to 'Approve', approve_admin_photo_path(pg)
          end
          column do
            link_to 'Ban', ban_admin_photo_path(pg)
          end
        elsif pg.aasm_state == 'approved'
          column do
            link_to 'Ban', ban_admin_photo_path(pg)
          end
        else
          column do
            link_to 'Approve', approve_admin_photo_path(pg)
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
      row :user_id do
        link_to('Author', admin_user_path(photo.user_id))
      end
      row :rating
      row :created_at
      row :updated_at
      row :id
      row :aasm_state
    end
    active_admin_comments
  end
  member_action :approve do
    resource.approve!
    redirect_to admin_photos_path
  end

  member_action :ban do
    resource.ban!
    RemovePhotoWorker.perform_in(20.minutes, params[:id])
    redirect_to admin_photos_path
  end
end
