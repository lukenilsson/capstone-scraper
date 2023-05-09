class ProductsController < ApplicationController
  require "nokogiri"
  require "httparty"

  def scrape_products
    url = "https://www.chewy.com/brands/homeopet-6907?nav-submit-button=&ref-query=homeopet&ref=searchRedirect"

    response = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(response.body)

    product_names = parsed_page.css(".kib-product-title")
    product_prices = parsed_page.css(".kib-product-pricing__row")

    products = product_names.zip(product_prices).map do |name, price|
      product_name = name.css("div.kib-product-title__text").text.strip
      product_price = price.css("div.kib-product-price.kib-product-price--md").text.strip.gsub("Chewy Price", "").strip

      next if product_name.include?("Bundle:") || product_price.include?("Autoship Price") || product_price.include?("$29.98")

      { name: product_name, price: product_price }
    end.compact

    render json: { products: products }
  end
end
