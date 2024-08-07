class Service < ApplicationRecord
  validates :title, :description, :image, presence: true

  belongs_to :business_plan
  mount_uploader :image, ImageUploader
end
