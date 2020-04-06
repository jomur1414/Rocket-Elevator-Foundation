require 'test_helper'

class QuotesControllerTest < ActionDispatch::IntegrationTest
  test "should get submission" do
    get quotes_submission_url
    assert_response :success
  end

end
