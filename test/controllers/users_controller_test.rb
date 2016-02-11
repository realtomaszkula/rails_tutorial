require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get signup" do
    get :signup
    assert_response :success
    assert_select "title", "Sign up | Ruby on Rails Tutorial Sample App"
  end


end
