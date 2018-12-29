Rails.application.routes.draw do
  root 'main_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 get '/auth/:provider/callback', to: 'session_controller#create'

  delete '/logout', to: 'session_controller#destroy'

end
