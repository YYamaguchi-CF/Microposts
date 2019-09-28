Rails.application.routes.draw do
  root to: 'toppages#index'
  
  # Sessionルート
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # Userルート
  get 'signup', to: 'users#new'
  resources :users, except: [:edit , :update, :destroy] do
  	member do
  		get :followings
  		get :followers
  		get :likes
  	end
  end
  
  resources :microposts, only: [:show, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resource :account, only: [:edit, :update]
  resource :password, only: [:show, :edit, :update]
end
