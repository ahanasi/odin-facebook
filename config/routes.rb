Rails.application.routes.draw do
  concern :commentable do
    resources :comments
    resources :likes
  end
  resources :posts, concerns: :commentable
  resources :comments, concerns: :commentable

  resources :posts, only: %i[edit] do
    delete 'delete_image_attachment', on: :member
  end

  resources :friendships, only: [:create] do
    collection do
      put :accept
      delete :cancel
      delete :decline
      delete :delete
    end
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: %i[show edit update] do
    member do
      get :posts
      get :friends
      get :requests
      get :liked_posts
    end
  end
  root 'posts#index'
end
