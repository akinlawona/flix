Rails.application.routes.draw do
 
  
  resources :genres
  resources :gensons
  resources :favorites
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "movies#index"
  resources :movies do 
     resources :reviews
     resources :favorites, only: [:create, :destroy]
  end 

  resource :session, only: [:new,:create, :destroy ]

  resources :users
 get "movies/filter/:filter" => "movies#index", as: :filtered_movies
  get "signup" => "users#new"
  get "signin" => "sessions#new"

end
