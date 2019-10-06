class RoadmapHeader < ApplicationRecord
  belongs_to :user

  # roadmap_detailを１つ所持
  has_one :roadmap_detail, dependent: :destroy

  # デフォルトでcreated_atを逆順でソート
  default_scope -> { order(created_at: :desc) }

  # Formでroadmap_detailを複数所持可能にする
  # allow_destroy : formでdestroyを指定すると子要素を削除する
  # reject_if : すべての入力属性が空の場合、roadmap_detailモデルを作成しない（バリデーションも実行しない）
  #             １つでも属性を入力した場合、roadmap_detailモデルを作成する（バリデーションも実行される）
  accepts_nested_attributes_for :roadmap_detail, allow_destroy: true

  # バリデーション
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :assumption_level, length: { maximum: 400 }
end
