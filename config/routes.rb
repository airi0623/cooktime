Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  get 'choices' => 'choices#index'

  resources :users do
    member do
      get 'profile'
    end
  end
  resources :recipes do
    # choiceのcreateとdeleteを追加
    post 'choices' => 'choices#create'
    delete '/choices' => 'choices#destroy'
    resources :ingredients
    collection do
      get 'about'
      get 'more'
    end
  end
  resources :things
end
