require 'test_helper'

class TrainingeventControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get trainingevent_new_url
    assert_response :success
  end

  test "should get create" do
    get trainingevent_create_url
    assert_response :success
  end

end
