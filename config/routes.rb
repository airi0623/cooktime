Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  resources :things
  get 'choices' => 'choices#index'
  get 'likes' => 'likes#index'
  get 'recipes/search'

  resources :users do
    member do
      get 'profile'
      get 'my_recipe'
      get 'do_cook'
    end
  end

  resources :recipes do
    post 'choices' => 'choices#create'
    delete '/choices' => 'choices#destroy'
    post 'likes' => 'likes#create'
    delete '/likes' => 'likes#destroy'
    resources :ingredients
    collection do
      get 'about'
      get 'more'
    end
  end
end
