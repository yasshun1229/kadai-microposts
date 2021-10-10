class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 255 }
  belongs_to :micropost
  validates :content, presence: true, length: { maximum: 255 }
end