Rails.application.routes.draw do
  post 'login', to: 'auth#create'
  post 'logout', to: 'auth#destroy'
  resources :hangtimes
  resources :availabilities
  resources :friendships
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
