require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @user = users(:general_user)
  end

  test "should redirect from users_path to new_user_session_url when not logged in" do
    get users_path
    assert_response :redirect
    assert_redirected_to new_user_session_url
  end

  test "should get users_path when logged in" do
    login_as(@user, :scope => :user)
    get users_path(@user)
    assert_response :success
  end

end
