Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  get 'choices' => 'choices#index'
  resources :users
  resources :recipes do
    # choiceのcreateとdeleteを追加
    post 'choices' => 'choices#create'
    delete '/choices' => 'choices#destroy'
    resources :ingredients
    collection do
      get 'about'
    end
  end
  resources :things
end
