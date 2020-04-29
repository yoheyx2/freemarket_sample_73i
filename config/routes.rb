Rails.application.routes.draw do
  root "products#index"

  resources :products, only: [:index, :show, :new, :create]
  resources :categories, only: [:show]

end
