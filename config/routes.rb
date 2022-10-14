Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post "/user" => "users#create"
  post "/sessions" => "sessions#create"
  get "/warehouses" => "warehouse#index"
  get "/warehouses/:id" => "warehouse#show"
  post "/shipments" => "shipment#create"
  get "/shipments" => "shipment#index"
  patch "/shipments/:id" => "shipment#update"
  get "/shipments/:id" => "shipment#show"
  delete "/shipments/:id" => "shipment#destroy"
  get "/inventory" => "inventories#index"
  get "/inventory/:id" => "inventories#show"
  get "/books" => "books#index"
  get "/prints" => "prints#index"
  post "/prints" => "prints#create"
  get "/prints/:id" => "prints#show"
  patch "/prints/:id" => "prints#update"
  delete "/prints/:id" => "prints#destroy"
end
