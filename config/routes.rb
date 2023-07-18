Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resources :search, only: :index
  resources :history, only: [:index, :show], module: :search

  resources :princing, only: :index
  resources :about, only: :index
  resources :contact, only: :index
end
