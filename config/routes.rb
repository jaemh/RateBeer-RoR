Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries

  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  get 'signout', to: 'sessions#destroy'
  post 'places', to:'places#search'
  get '/places/:id', to: 'places#show', as: 'place'

  
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :places, only: [:index, :show]

  root 'breweries#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
