require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get auth_new_url
    assert_response :success
  end
end
