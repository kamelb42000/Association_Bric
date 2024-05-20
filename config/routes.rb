Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :informations
  resources :services

  resources :products do
    resources :bookings, only: [:create]
  end

  resources :bookings, only: [:index, :show, :create, :update, :destroy] do
    member do
      put :accept
      put :refuse
    end
  end

  resources :members
end
