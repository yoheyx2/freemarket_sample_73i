Rails.application.routes.draw do
  devise_for :users
  
  root "products#index"

  resources :products do
    member do
      get 'purchase'
    end
    collection do
      get "set_parents"
      get "set_children"
      get "set_grandchildren"
    end
  end

  resources :categories, only: [:show]
  resources :users, only: [:index]
end
