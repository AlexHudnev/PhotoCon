# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      get '/users/current', to: 'users#current'
      resources :photos
      resources :comments
      resources :likes
      resources :users
      get '/users/:id/photos', to: 'users#photos'
      get '/photos/:photo_id/comments', to: 'photos#comments'
      get '/photos/:photo_id/likes', to: 'photos#likes'
    end
    resources :photos
    resources :comments
    resources :likes
    resources :users
  end

  root 'photos#index'
  post 'photos', to: 'photos#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/auth/:provider/callback', to: 'session_controller#create'
  get 'download_zip', to: 'photos#download_zip'
  delete '/logout', to: 'session_controller#destroy'
  get 'search', to: 'photos#search'
  match '/rating', to: 'photos#rating', via: 'get'
  match '/gallery', to: 'photos#gallery', via: 'get'
  match '/photo/:id', to: 'photos#show', via: 'get'
  match '/user/:id', to: 'users#show', via: 'get'
  post '/users/:user_id/photos/:photo_id/comments/:parent_comment_id/comments',
       to: 'comments#create', as: 'user_photo_comment_comments'
  post '/users/:id', to: 'users#token'
  get '/users/:user_id/photos/:photo_id/comments/:parent_comment_id/new',
      to: 'comments#new', as: 'new_user_photo_comment_comment'
  get '/share/', to: 'photos#share'
  resources :users
  resources :likes
  resources :photos do
    resources :comments
    resources :likes, only: [:create]
  end
end
