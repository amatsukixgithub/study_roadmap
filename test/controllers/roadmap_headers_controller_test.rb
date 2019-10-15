require 'test_helper'

class RoadmapHeadersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:general_user)
    @user_other = users(:other_user)
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

  test "未ログイン時はロードマップ作成不可" do
    assert_difference 'RoadmapHeader.count', 0 do
      post roadmap_create_path,
           params: {
             roadmap_header: {
               title: "title is title",
               roadmap_detail_attributes: {
                 sub_title: "sub_title",
                 content: "context",
                 time_required: ""
               }
             }
           }
    end
    assert_response :redirect
    assert_redirected_to user_session_path
  end

  test "ログイン後はロードマップ作成可能" do
    login_as @user
    assert_difference 'RoadmapHeader.count', +1 do
      post roadmap_create_path,
           params: {
             roadmap_header: {
               title: "title is title",
               roadmap_detail_attributes: {
                 sub_title: "sub_title",
                 content: "context",
                 time_required: ""
               }
             }
           }
    end
    assert_response :redirect
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

  test "作成者以外のユーザーはリダイレクト" do
    login_as @user_other
    get roadmap_edit_path(@roadmap_header)
    assert_response :redirect
    assert_redirected_to roadmaps_path
  end

  test "未ログイン時はロードマップ編集不可" do
    patch roadmap_edit_path(@roadmap_header),
          params: {
            roadmap_header: {
              title: "title is title",
              roadmap_detail_attributes: {
                sub_title: "sub_title",
                content: "context",
                time_required: ""
              }
            }
          }
    assert_response :redirect
    assert_redirected_to user_session_path
  end

  test "ログイン後はロードマップ編集可能" do
    login_as @user
    patch roadmap_edit_path(@roadmap_header),
          params: {
            roadmap_header: {
              title: "title is title",
              roadmap_detail_attributes: {
                sub_title: "sub_title",
                content: "context",
                time_required: ""
              }
            }
          }
    assert_response :redirect
    assert_redirected_to roadmap_show_path(@roadmap_header)
  end

  test "作成者以外のユーザーがログインしている場合はロードマップ編集不可" do
    login_as @user_other
    patch roadmap_edit_path(@roadmap_header),
          params: {
            roadmap_header: {
              title: "title is title",
              roadmap_detail_attributes: {
                sub_title: "sub_title",
                content: "context",
                time_required: ""
              }
            }
          }
    assert_response :redirect
    assert_redirected_to roadmaps_path
  end

  # ---ロードマップ削除---
  test "ログイン後は作成者であればロードマップ削除可" do
    login_as @user
    assert_difference 'RoadmapHeader.count', -1 do
      delete roadmap_destroy_path(@roadmap_header)
    end
    assert_response :redirect
    assert_redirected_to roadmaps_path
  end

  test "ログイン後で作成者でない場合ロードマップ削除不可" do
    login_as @user_other
    assert_difference 'RoadmapHeader.count', 0 do
      delete roadmap_destroy_path(@roadmap_header)
    end
    assert_response :redirect
    assert_redirected_to roadmaps_path
  end

  test "未ログイン時はロードマップ削除不可" do
    assert_difference 'RoadmapHeader.count', 0 do
      delete roadmap_destroy_path(@roadmap_header)
    end
    assert_response :redirect
    assert_redirected_to user_session_path
  end
end
