Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#show'
  resources :users
  resources :recipes do
    resources :ingredients
  end
  resources :things
end
