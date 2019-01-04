require 'test_helper'

class VersionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get version_new_url
    assert_response :success
  end

  test "should get create" do
    get version_create_url
    assert_response :success
  end

end
