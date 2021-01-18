Rails.application.routes.draw do
  resources :posts
  resources :friendships, only: [:create]
  devise_for :users
  root "posts#index"
end
