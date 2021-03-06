Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  get 'my_recipes', to: 'recipes#my_recipes'
  get 'my_favorite_recipes', to: 'recipes#my_favorite_recipes'
  get 'my_lists', to: 'lists#my_lists'
  get 'list_recipes', to: 'lists#list_recipes'

  resources :recipes do
    collection do
      get 'search'
      get 'all'
    end

    member do
      get 'favorite'
      delete 'favorite', to: 'recipes#unfavorite'
      post 'add_list'
    end
  end
  
  resources :recipe_types, :cuisines, :lists, only: [:new, :create, :show]
  resources :users, only: [:show]
end
