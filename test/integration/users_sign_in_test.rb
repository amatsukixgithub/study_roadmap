# frozen_string_literal: true
require 'test_helper'

class UsersSignInTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:general_user)
    @other_user = users(:general_user)
    @admin_user = users(:admin_user)
  end

  # --- [devise gem] ユーザー登録(/users/sign_up) ---
  test "ログインしていないとき、ユーザー登録ページにアクセス" do
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
  end

  # --- [devise gem] ログアウト(/users/sign_out) ---
  # サインアウト
  test "should sign out when delete destroy_user_session_path after logged in" do
    login_as @user
    delete destroy_user_session_path

    assert_response :redirect
    assert_redirected_to root_url

    follow_redirect!
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

  # ユーザー編集ページでユーザーのコメント、Webページ、を変更
  test "should change comment and web_page when post edit_user_registration_path" do
    login_as @user
    get edit_user_registration_path
    assert "comment", @user.comment
    assert "web_page", @user.web_page
    post users_path, params: { session: { email: @user.email, password: 'password', comment: 'change_comment', web_page: 'change_web_page' } }

    assert_response :redirect
    assert_redirected_to root_url
    assert "change_comment", @user.comment
    assert "change_web_page", @user.web_page
  end

  # --- ユーザー一覧(/users) ---
  # 管理ユーザー：ユーザー削除後のユーザー数-1、削除ボタン表示
  test "should delete other_user when delete user_delete_path after logged in admin user" do
    login_as @admin_user
    get users_path
    assert_response :success
    # 管理者：ユーザー削除ボタン表示
    assert_select "input[value=?]", "delete"
    assert_select "a[href=?]", user_show_path(@admin_user.id), text: @admin_user.name

    assert_difference 'User.count', -1 do
      delete user_delete_path(@other_user)
    end
    assert_response :redirect
    assert_redirected_to users_path
  end

  # 一般ユーザー：ユーザー削除後のユーザー数±0、削除ボタン非表示
  test "can not delete other_user when delete user_delete_path after logged in general user" do
    login_as @user
    get users_path
    assert_response :success
    # 一般：ユーザー削除ボタン非表示
    assert_select "input[value=delete]", false
    assert_select "a[href=?]", user_show_path(@user.id), text: @user.name

    assert_difference 'User.count', 0 do
      delete user_delete_path(@other_user)
    end
    assert_response :redirect
    assert_redirected_to users_path
  end

  # --- ユーザー個人ページ(/users/:id/show) ---

  # --- ロードマップ一覧(/roadmaps) ---
  # --- ロードマップ詳細(/roadmaps/:id/show) ---
  # --- ロードマップ新規作成 ---
  # --- ロードマップ編集 ---
  # --- ロードマップ削除 ---
end
