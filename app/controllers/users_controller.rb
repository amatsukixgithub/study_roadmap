class UsersController < ApplicationController
  # devise のヘルパー ログイン済みユーザーのみアクセス許可
  before_action :authenticate_user!, only: [:index]

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
end
