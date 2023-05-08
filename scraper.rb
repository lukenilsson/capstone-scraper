require "nokogiri"
require "open-uri"

url = "https://www.petsmart.com/search/?q=homeopet&ps=undefined&fmethod=Search"
doc = Nokogiri::HTML(URI.open(url))

product_elements = doc.css(".search-results-product")

product_elements.each do |product_element|
  product_title = product_element.css(".product-name").text.strip
  price = product_element.css(".price").text.strip

  puts "Product Title: #{product_title}"
  puts "Price: #{price}"
  puts "-------------------------"
end
