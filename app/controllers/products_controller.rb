class ProductsController < ApplicationController
  require "nokogiri"
  require "httparty"

  def index
    @products = Product.all
    render :index
  end

  def scrape_products
    url = "https://www.chewy.com/brands/homeopet-6907?nav-submit-button=&ref-query=homeopet&ref=searchRedirect"

    response = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(response.body)

    products = parsed_page.css(".kib-product-title")

    products.each do |product|
      title = product.css("div.kib-product-title__text").text.strip
      puts title
    end

    render json: { message: "Scraping Complete!" }
  end
end
