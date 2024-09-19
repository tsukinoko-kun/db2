require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "CORS options" do
    process(:options, posts_url)
    assert_response :success

    assert_equal "http://localhost:4000", response.headers["Access-Control-Allow-Origin"]
    assert_equal "GET,POST,PUT,PATCH,DELETE,OPTIONS,HEAD", response.headers["Access-Control-Allow-Methods"]
    assert_equal "Origin,X-Requested-With,Content-Type,Accept,Authorization", response.headers["Access-Control-Allow-Headers"]
    assert_equal "true", response.headers["Access-Control-Allow-Credentials"]
  end
end
