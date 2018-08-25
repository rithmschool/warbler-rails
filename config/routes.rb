Rails.application.routes.draw do
  devise_for :users
  resources :messages, only: [:new, :show, :create, :destroy]

  root to: "pages#home"
end
