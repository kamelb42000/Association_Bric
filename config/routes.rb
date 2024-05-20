Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :informations
  resources :services
  
  resources :products do
    resources :bookings, only: [:create]
  end

  resources :bookings do
    member do
      put :accept
      put :refuse
    end
  end



  resources :members
  resources :products do
    resources :bookings, only: [:create, :index, :show, :update, :destroy] do
      member do
        patch :accept
        patch :refuse
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
