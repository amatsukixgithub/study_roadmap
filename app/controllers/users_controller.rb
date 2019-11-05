class UsersController < ApplicationController
  # devise のヘルパー ログイン済みユーザーのみアクセス許可
  before_action :authenticate_user!, only: [:index, :delete_user, :show_user]

  # ユーザー一覧ページ
  def index
    @users = User.all
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
    @roadmap_headers = RoadmapHeader.where(user: @user).joins("LEFT OUTER JOIN users ON roadmap_headers.user_id = users.id").select("roadmap_headers.*, users.*")
  end
end
