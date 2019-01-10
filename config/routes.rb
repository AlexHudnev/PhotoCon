Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'photos#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 get '/auth/:provider/callback', to: 'session_controller#create'

  delete '/logout', to: 'session_controller#destroy'
get 'search', to: 'photos#search'

#get '/users/:user_id/photos/:photo_id/comments/:parent_comment_id/photo/main2', to: 'comments#new', as: 'main2_photo'
  post '/users/:user_id/photos/:photo_id/comments/:parent_comment_id/comments', to: 'comments#create_sub_comment', as: 'user_photo_comment_comments'
get '/users/:user_id/photos/:photo_id/comments/:parent_comment_id/new', to: 'comments#new', as: 'new_user_photo_comment_comment'
resources :users
 resources :photos do
    resources :comments
resources :likes, only: [:create]
  end

end
