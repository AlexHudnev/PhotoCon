Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api, defaults: { format: :json }  do
    resources :users, only: [:index, :show] do
      get '/photos',   to: 'photos#index'
      resources :comments, only: :index, module: :users
    end
    resources :photos, only: [:index, :create, :show] do
      resources :comments, only: [:create, :index], module: :photos
      resources :likes, only: :create
    end
  end
  root 'photos#index'
  post 'photos', to: 'photos#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/auth/:provider/callback', to: 'session_controller#create'

  delete '/logout', to: 'session_controller#destroy'
  get 'search', to: 'photos#search'
  match '/rating', to: 'photos#rating', via: 'get'
  post '/users/:user_id/photos/:photo_id/comments/:parent_comment_id/comments', to: 'comments#create', as: 'user_photo_comment_comments'
  get '/users/:user_id/photos/:photo_id/comments/:parent_comment_id/new', to: 'comments#new', as: 'new_user_photo_comment_comment'
  resources :users
  resources :photos do
    resources :comments
    resources :likes, only: [:create]
  end
end
