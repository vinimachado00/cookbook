Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  get 'my_recipes', to: 'recipes#my_recipes'
  get 'my_lists', to: 'lists#my_lists'

  resources :recipes do
    collection do
      get 'search'
      get 'all'
    end

    member do
      get 'favorite'
      delete 'favorite', to: 'recipes#unfavorite'
    end
  end
  resources :lists, only: [:new, :create, :show]
  resources :recipe_types, only: [:new, :create, :show]
  resources :cuisines, only: [:new, :create, :show]
end
