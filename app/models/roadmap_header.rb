class RoadmapHeader < ApplicationRecord
  belongs_to :user

  has_one :roadmap_detail, dependent: :destroy

  # デフォルトでcreated_atを逆順でソート
  default_scope -> { order(created_at: :desc) }

  # バリデーション
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :assumption_level, length: { maximum: 400 }
end
