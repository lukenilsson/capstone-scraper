require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/scraper.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Product.count, data.length
  end
end
