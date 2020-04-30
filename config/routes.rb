Rails.application.routes.draw do
  devise_for :users
  
  root "products#index"

  resources :products, only: [:index, :show, :new, :create]
  resources :categories, only: [:show]
  resources :users, only: [:index]
end
