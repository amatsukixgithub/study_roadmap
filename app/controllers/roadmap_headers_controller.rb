class RoadmapHeadersController < ApplicationController
  # devise のヘルパー ログイン済みユーザーのみアクセス許可
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  # ロードマップ一覧表示
  def index
    @roadmap_headers = RoadmapHeader.all
  end

  # Roadmapの詳細画面
  def detail
    @roadmap_header = RoadmapHeader.find(params[:id])
    @roadmap_details = RoadmapDetail.where(roadmap_header_id: @roadmap_header.id)
  end

  # ロードマップ新規作成画面
  def new
    @roadmap_post = current_user.roadmap_header.build
    @roadmap_post.build_roadmap_detail
  end

  # ロードマップ作成
  def create
    @roadmap_post = current_user.roadmap_header.build(roadmap_header_params)
    if @roadmap_post.save
      redirect_to roadmap_show_path(@roadmap_post)
    else
      render "new"
    end
  end

  # ロードマップ編集
  def edit
    @roadmap_post = RoadmapHeader.find(params[:id])
  end

  # ロードマップ更新
  def update
    @roadmap_post = RoadmapHeader.find(params[:id])
    byebug
    if @roadmap_post.update_attributes(roadmap_header_params)
      redirect_to roadmap_show_path(@roadmap_post)
    else
      render "edit"
    end
  end

  private

  # Strong parameters 不要な情報が入り込まないようにする
  def roadmap_header_params
    # require(:roadmap_header) roadmap_header属性を必須とする
    # permit() 指定された属性を許可する
    params.require(:roadmap_header).permit(:title, roadmap_detail_attributes:[:sub_title, :content, :time_required])
  end

end