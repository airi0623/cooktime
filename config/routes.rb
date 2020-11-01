Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  resources :users
  resources :recipes do
    resources :ingredients
    collection do
      get 'about'
    end
  end
  resources :things
end
