Rails.application.routes.draw do
  resources :posts do
    resources :comments
    resources :likes
  end
  resources :posts, only: %i[edit] do
    member do
      delete :delete_image_attachment
    end
  end
  resources :comments do
    resources :comments
    resources :likes
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
  resources :users, only: %i[show edit update] do
    member do
      get :posts
      get :friends
      get :requests
    end
  end
  root 'posts#index'
end
