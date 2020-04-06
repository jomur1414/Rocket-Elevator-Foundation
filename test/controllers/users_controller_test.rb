require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get userinfo" do
    get users_userinfo_url
    assert_response :success
  end

end
