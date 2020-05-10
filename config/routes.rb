Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  root "products#index"

  resources :products, only: [:index, :show, :new, :create] do
    member do
      get 'purchase'
      post 'payment'
    end
    collection do
      get "set_parents"
      get "set_children"
      get "set_grandchildren"
    end
  end

  resources :cards, only: [:new, :create, :show, :destroy] do
  end
  resources :categories, only: [:show]
  resources :users, only: [:index]
  
  
end
    