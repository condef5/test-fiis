require "test_helper"

class ProductsUploadControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get products_upload_new_url
    assert_response :success
  end

  test "should get create" do
    get products_upload_create_url
    assert_response :success
  end
end
