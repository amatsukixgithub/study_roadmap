require 'test_helper'

class UsersSignInTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:general_user)
  end

  # --- [devise gem] ユーザー登録(/users/sign_up) ---
  # ログインしていないとき、ユーザー登録ページにアクセス
  test 'shoule get new_user_registration when get new_user_registration_path after not logged in' do
    get new_user_registration_path
    assert_response :success
  end

  # ログインしているとき、HOMEページにリダイレクト
  test "should redirect to root_url when get new_user_registration_path after logged in" do
    login_as @user
    get new_user_registration_path

    assert_response :redirect
    assert_redirected_to root_url
  end

  # --- [devise gem] ログイン(/users/sign_in) ---
  # ログインしていないとき、ログインページにアクセス
  test "should get new_user_session_path when get new_user_session_path after not logged in" do
    get new_user_session_path
    assert_response :success
  end

  # ログインしているとき、HOMEページにリダイレクト
  test "should redirect to root_url when get new_user_session_path after logged in" do
    login_as @user
    get new_user_session_path

    assert_response :redirect
    assert_redirected_to root_url

    follow_redirect!
    assert_select "h2", "現在 #{@user.name} さんがログインしています"
  end

  # --- [devise gem] ログアウト(/users/sign_out) ---
  # サインアウト
  test "should sign out when delete destroy_user_session_path after logged in" do
    login_as @user
    delete destroy_user_session_path

    assert_response :redirect
    assert_redirected_to root_url

    follow_redirect!
    assert_select "h2", "現在ログインしていません"
  end

  # --- [devise gem] ユーザー編集(/users/edit) ---
  # ログインしていないとき、ログインページにリダイレクト
  test "should redirect to new_user_session_url when get edit_user_registration_path after not logged in" do
    get edit_user_registration_path
    assert_response :redirect
    assert_redirected_to new_user_session_url
  end

  # ログインしているとき、ユーザー編集ページにアクセス
  test "should get edit_user_registration_path when get edit_user_registration_path after logged in" do
    login_as @user
    get edit_user_registration_path
    assert_response :success
  end

  # ユーザー編集ページでユーザーの名前を 'general' から 'change_name' に変更
  test "should change name from 'general' to 'change_user' when post edit_user_registration_path" do
    login_as @user
    get edit_user_registration_path
    assert "general", @user.name
    post users_path, params: { session: { email: @user.email, password: 'password', name: 'change_name' } }

    assert_response :redirect
    assert_redirected_to root_url
    assert "change_name", @user.name
  end

  # --- ユーザー一覧(/users) ---
  # ユーザー削除後のユーザー数 -1
  test "should delete other_user when delete user_delete_path" do
    login_as @user
    assert_difference 'User.count', -1 do
      delete user_delete_path(@other_user)
    end
    assert_redirected_to users_path
  end

end
