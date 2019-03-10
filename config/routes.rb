Rails.application.routes.draw do
  root to: 'recipes#index'
  resources :recipes do
    get 'search', on: :collection
    member do
      get 'favorite'
      delete 'favorite', to: 'recipes#unfavorite'
    end
  end
  resources :recipe_types, only: [:new, :create, :show]
  resources :cuisines, only: [:new, :create, :show]
end
