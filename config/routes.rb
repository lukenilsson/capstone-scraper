Rails.application.routes.draw do
  get "/products" => "products#index"
  get "/products/scraper" => "products#scrape_products"
end
