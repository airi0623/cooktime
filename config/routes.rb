Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#new'
  resources :users
  resources :recipes
  # do
  #   resources :ingredients
  # end
  resources :things
end
