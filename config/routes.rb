# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      resources :photos
      resources :comments
      resources :likes
      resources :users
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

  delete '/logout', to: 'session_controller#destroy'
  get 'search', to: 'photos#search'
  match '/rating', to: 'photos#rating', via: 'get'
  match '/gallery', to: 'photos#gallery', via: 'get'
  match '/photo/:id', to: 'photos#show', via: 'get'
  match '/user/:id', to: 'users#show', via: 'get'
  post '/users/:user_id/photos/:photo_id/comments/:parent_comment_id/comments',
       to: 'comments#create', as: 'user_photo_comment_comments'
  get '/users/:user_id/photos/:photo_id/comments/:parent_comment_id/new',
      to: 'comments#new', as: 'new_user_photo_comment_comment'
  resources :users
  resources :likes
  resources :photos do
    resources :comments
    resources :likes, only: [:create]
  end
end
