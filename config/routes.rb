Rails.application.routes.draw do
  root to: 'toppages#index'
  
  # Sessionルート
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # Userルート
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
end
