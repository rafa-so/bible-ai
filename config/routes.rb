Rails.application.routes.draw do
  get 'search/index'

  root 'welcome#index'

  resources :princing, only: :index
  resources :about, only: :index
  resources :contact, only: :index
end
