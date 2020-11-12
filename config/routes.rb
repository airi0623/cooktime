Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  root to: 'recipes#index'
  resources :things
  get 'choices' => 'choices#index'
  get 'likes' => 'likes#index'
  get 'recipes/search_result'
  get 'recipes/search'
  post 'recipes/shoplist' 

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
