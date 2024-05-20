Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :informations
  resources :services, only: [:index, :show, :edit, :update]
  resources :services do
    member do
      put :validate
      put :refuse
    end
  end

  resources :products do
    resources :bookings, only: [:create]
  end

  resources :bookings, only: [:index, :show, :create, :update, :destroy] do
    member do
      put :accept
      put :refuse
    end
  end

  resources :members do
    resources :services, only: [:index, :show]
  end

end
