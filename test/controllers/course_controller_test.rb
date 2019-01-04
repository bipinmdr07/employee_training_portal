require 'test_helper'

class CourseControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get course_new_url
    assert_response :success
  end

end
