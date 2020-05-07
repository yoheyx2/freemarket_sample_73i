Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  root "products#index"

  resources :products, only: [:index, :show, :new, :create] do
    member do
      get 'purchase'
    end
  end

  resources :categories, only: [:show]
  resources :users, only: [:index]
  
  
end
    