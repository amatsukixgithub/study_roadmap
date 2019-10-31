class RoadmapDetail < ApplicationRecord
  belongs_to :roadmap_header

  # バリデーション
  validates :roadmap_header, presence: true
  validates :sub_title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 50000 }
  has_rich_text :content
  validates :pic_pass1, length: { maximum: 300 }
  validates :pic_pass2, length: { maximum: 300 }
  validates :pic_pass3, length: { maximum: 300 }
  validates :pic_pass4, length: { maximum: 300 }
end
