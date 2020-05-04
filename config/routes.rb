Rails.application.routes.draw do
  devise_for :users
  
  root "products#index"

  resources :products, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      get 'purchase'
    end
  end

  resources :categories, only: [:show]
  resources :users, only: [:index]
end
