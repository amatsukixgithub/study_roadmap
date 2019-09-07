class UsersController < ApplicationController
  # devise のヘルパー ログイン済みユーザーのみアクセス許可
  before_action :authenticate_user!, only: [:index]

  def index
    @users = User.all
  end
end
