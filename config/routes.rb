Rails.application.routes.draw do

  root to: 'welcome#index'
  resources :users, only: [:new, :create]
  get '/profile', to: 'users#show'
  get 'login', to: "users#login_form"
  post '/login', to: 'users#login_user'
  delete '/logout', to: "users#logout"
  get '/edit_profile', to: "users#edit"
  patch '/profile', to: "users#update"
end
