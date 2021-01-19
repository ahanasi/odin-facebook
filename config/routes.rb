Rails.application.routes.draw do
  resources :posts
  resources :friendships, only: [:create]
  resources :users
  devise_for :users
  root "posts#index"
end
