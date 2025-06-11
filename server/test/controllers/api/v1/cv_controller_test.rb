require "test_helper"

class Api::V1::CvControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_cv_index_url
    assert_response :success
  end
end
