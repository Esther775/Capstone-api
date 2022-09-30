Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post "/user" => "users#create"
  post "/sessions" => "sessions#create"
  get "/warehouses" => "warehouse#index"
  post "/shipments" => "shipment#create"
  get "/shipments" => "shipment#index"
  patch "/shipments/:id" => "shipment#update"
  get "/shipments/:id" => "shipment#show"
  delete "/shipments/:id" => "shipment#destroy"
  get "/inventory/:id" => "inventories#show"
end
