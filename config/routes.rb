Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  get '/profile', to: 'users#show'
  get '/', to: 'welcome#index'
  get 'login', to: "users#login_form"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
