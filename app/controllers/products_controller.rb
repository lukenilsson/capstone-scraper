class ProductsController < ApplicationController
  require "nokogiri"
  require "httparty"

  def scrape_products
    url = "https://www.chewy.com/brands/homeopet-6907?nav-submit-button=&ref-query=homeopet&ref=searchRedirect"

    response = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(response.body)

    product_names = parsed_page.css(".kib-product-title")
    product_prices = parsed_page.css(".kib-product-pricing__row")

    names = product_names.map do |product|
      title = product.css("div.kib-product-title__text").text.strip
      title unless title.include?("Bundle:")
    end.compact

    prices = product_prices.map do |product|
      price = product.css("div.kib-product-price.kib-product-price--md").text.strip.gsub("Chewy Price", "").strip
      price unless price.include?("Autoship Price") || price.include?("$29.98")
    end.compact

    render json: { names: names, prices: prices }
  end
end
