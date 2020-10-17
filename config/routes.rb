Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#new'
  resources :users
  resources :recipes
end
