Rails.application.routes.draw do
  get "/scraper" => "products#scrape_products"
  post "/users" => "users#create"
  post "/sessions" => "sessions#create"
end
