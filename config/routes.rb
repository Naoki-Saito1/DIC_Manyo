Rails.application.routes.draw do
  get 'labels/new'
  get 'labels/index'
  get 'labels/create'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create,:show]
  resources :tasks
  root to: 'users#new'
  
  namespace :admin do
    resources :users
  end
end
