require 'test_helper'

class RoadmapHeadersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:general_user)
    @roadmap_header = roadmap_headers(:ruby)
  end

  # ---roadmap一覧ページ---
  test "ロードマップ一覧ページにアクセス可" do
    get roadmaps_path
    assert_response :success
  end

  test "ログイン後にロードマップ一覧ページにアクセス可" do
    login_as @user
    get roadmaps_path
    assert_response :success
  end

  # ---ロードマップ詳細ページ---
  test "ロードマップ詳細ページにアクセス可" do
    get roadmap_show_path(@roadmap_header)
    assert_response :success
  end

  test "ログイン後にロードマップ詳細ページにアクセス可" do
    login_as @user
    get roadmap_show_path(@roadmap_header)
    assert_response :success
  end

  # ---ロードマップ作成ページ---
  test "未ログイン時はロードマップ作成ページからログインページへリダイレクト" do
    get roadmap_new_path
    assert_response :redirect
    assert_redirected_to user_session_path
  end

  test "ログイン後はロードマップ作成ページにアクセス可" do
    login_as @user
    get roadmap_new_path
    assert_response :success
  end

  # ---ロードマップ編集ページ---
  test "未ログイン時はロードマップ編集ページからログインページへリダイレクト" do
    get roadmap_edit_path(@roadmap_header)
    assert_response :redirect
    assert_redirected_to user_session_path
  end

  test "ログイン後はロードマップ編集ページにアクセス可" do
    login_as @user
    get roadmap_edit_path(@roadmap_header)
    assert_response :success
  end

  # ---ロードマップ削除---
  test "" do
    login_as @user
    assert_difference 'RoadmapHeader.count', -1 do
      delete roadmap_destroy_path(@roadmap_header)
    end
    assert_response :redirect
    assert_redirected_to roadmaps_path
  end
end
