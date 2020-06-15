Rails.application.routes.draw do
 
  
  resources :gensons
  resources :genres
  resources :favorites
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "movies#index"
  resources :movies do 
     resources :reviews
     resources :favorites, only: [:create, :destroy]
  end 

  resource :session, only: [:new,:create, :destroy ]

  resources :users

  get "signup" => "users#new"
  get "signin" => "sessions#new"

end
