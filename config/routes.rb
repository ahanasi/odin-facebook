Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end
  resources :comments do
    resources :comments
  end
  resources :friendships, only: [:create] do
    collection do
      put :accept
      delete :cancel
      delete :decline
      delete :delete
    end
  end
  devise_for :users
  resources :users do
    member do
      get :posts
    end
  end
  root 'posts#index'
end
