class User < ApplicationRecord
  has_many :roadmap_header, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :web_page, length: { maximum: 400 }
  validates :comment, length: { maximum: 400 }
end
