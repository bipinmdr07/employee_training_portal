require 'test_helper'

class ApplicationuserinroleControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get applicationuserinrole_new_url
    assert_response :success
  end

  test "should get create" do
    get applicationuserinrole_create_url
    assert_response :success
  end

end
