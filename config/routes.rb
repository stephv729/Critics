Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "games#index"

  resources :games
  resources :users, except: %i[index show]
  resources :companies
  resources :critics, except: %i[index show]
  get "critics/aprove"
  get "/delete_data", to: "games#delete_data"
  post "/update_data", to: "games#update_data"
  get "/games/:id/critics", to: "games#critics", as: "game_critics"
  get "/companies/:id/details", to: "companies#description_and_critics", as: "details_company"

  # Defines the root path route ("/")
  # root "articles#index"
end
