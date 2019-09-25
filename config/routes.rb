Rails.application.routes.draw do
  root to: 'toppages#index'
  
  # Sessionルート
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # Userルート
  get 'signup', to: 'users#new'
  resources :users, except: [:destroy] do
  	member do
  		get :followings
  		get :followers
  		get :likes
  	end
  end
  
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
