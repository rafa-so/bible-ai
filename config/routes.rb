Rails.application.routes.draw do
  get 'search/index'

  root 'welcome#index'
end
