Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :products do
    resources :bookings, only: [:create]
  end

  resources :bookings
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
