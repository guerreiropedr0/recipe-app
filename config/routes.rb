Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :foods, only: %i[index show new create destroy]

  # Defines the root path route ("/")
  root "home#index"

  resources :recipes, only: [:index, :show, :new, :create, :destroy]
  resources :inventories, only: %i[index show]

  get '/public_recipes', to: 'recipes#public_recipes'
end
