class UsersController < ApplicationController
  # devise のヘルパー ログイン済みユーザーのみアクセス許可
  before_action :authenticate_user!, only: [:index, :delete_user, :show_user, :following, :followers]
  # 作成者 or 管理者
  before_action :correct_user, only: [:delete_user]

  # ユーザー一覧ページ
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  # ユーザー一覧ページからのユーザー削除
  def delete_user
    if current_user.admin?
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
    else
      flash[:error] = "Error not delete"
    end
    redirect_to users_path
  end

  # ユーザー個人ページ
  def show_user
    @current_user_page = params[:id].to_i == current_user.id
    @user = User.find(params[:id])
    @roadmap_headers = RoadmapHeader.where(user: @user).joins("LEFT OUTER JOIN users ON roadmap_headers.user_id = users.id").select("roadmap_headers.*, users.name")
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  # 作成者 or 管理者 以外のユーザーはアクセスできない
  def correct_user
    user_id = User.find(params[:id])
    return if user_id == current_user.id || current_user.admin?

    redirect_to(users_path)
  end
end
