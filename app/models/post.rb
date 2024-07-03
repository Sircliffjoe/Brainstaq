class Post < ApplicationRecord
	belongs_to :user
	belongs_to :category
  has_one_attached :image
  has_many_attached :optional_images

  validates :title, :short_description, :content, :category_id, presence: true
end