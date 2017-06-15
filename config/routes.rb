Rails.application.routes.draw do
  root to: 'pages#home'

  get  '/hark',     to: 'pages#hark'
  get  '/hark/:id', to: 'posts#show'
  get  '/raven',    to: 'pages#about'
  get  '/contact',  to: 'pages#contact'

  get 'password_resets/new'
  get 'password_resets/edit'

  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :posts do
  	resources :comments
  end
end
