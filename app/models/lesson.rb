class Lesson < ApplicationRecord
  belongs_to :course, counter_cache: true
  belongs_to :chapter, counter_cache: true
  has_many :user_lessons, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :content, :course, :chapter, presence: true
  validates :title, length: { maximum: 100 }
  validates :title, uniqueness: { scope: :course_id }
  validates :vimeo, presence: true

  has_rich_text :content

  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  include RankedModel
  ranks :row_order, with_same: %i[course_id chapter_id]


  def impressions_count
    # to be replaced with counter_culture gem (conter cache)
    user_lessons.map(&:impressions).sum
  end

  def prev
    course.lessons.where('row_order < ?', row_order).order(:row_order).last
  end

  def next
    course.lessons.where('row_order > ?', row_order).order(:row_order).first
  end
end
