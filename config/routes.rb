Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  resources :messages, only: [:new, :show, :create, :destroy]
  resources :users, only: [:show] do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  get "/search", to: "pages#search"
  root to: "pages#home"
end
