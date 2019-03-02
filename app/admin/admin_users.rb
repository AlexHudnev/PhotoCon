# frozen_string_literal: true

ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  actions :all, except: [:destroy]
  index do
    selectable_column
    id_column
    column :email
    column I18n.t('active_admin.current_sign_in'), :current_sign_in_at
    column I18n.t('active_admin.comments.created_at'), :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
