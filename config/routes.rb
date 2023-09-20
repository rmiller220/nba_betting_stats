Rails.application.routes.draw do

  resources :users, only: [:new, :create]
  get '/profile', to: 'users#show'
  root to: 'welcome#index'
  get 'login', to: "users#login_form"
  post '/login', to: 'users#login_user'
  delete '/logout', to: "users#logout"
  get '/edit_profile', to: "users#edit"
  patch '/profile', to: "users#update"
end
