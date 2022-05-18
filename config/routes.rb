Rails.application.routes.draw do
  get 'inventories/index'
  get 'inventories/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :recipes, only: [:index, :show]
  resources :inventories, only: %i[index show]
  get '/public_recipes', to: 'recipes#public_recipes'
end
