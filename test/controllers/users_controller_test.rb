require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:general_user)
    @other_user = users(:other_user)
  end

  # ---ユーザー一覧ページ(/users)---
  test "should redirect from users_path to new_user_session_url when not logged in" do
    get users_path
    assert_response :redirect
    assert_redirected_to new_user_session_url
  end

  test "should get users_path when logged in" do
    login_as @user
    get users_path
    assert_response :success
  end

end
