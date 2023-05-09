Rails.application.routes.draw do
  get "/scraper" => "products#scrape_products"
end
