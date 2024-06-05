# frozen_string_literal: true

class Chapter < ApplicationRecord
  belongs_to :course, counter_cache: true
  has_many :lessons, dependent: :destroy, inverse_of: :chapter

  validates :title, :course, presence: true
  validates :title, length: { maximum: 100 }
  validates :title, uniqueness: { scope: :course_id }


  include RankedModel
  ranks :row_order, with_same: :course_id

end
