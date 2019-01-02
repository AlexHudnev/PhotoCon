Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'photos#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 get '/auth/:provider/callback', to: 'session_controller#create'

  delete '/logout', to: 'session_controller#destroy'
get 'search', to: 'photos#search'
resources :users
 resources :photos do
    resources :comments
resources :likes, only: [:create]
  end

end
