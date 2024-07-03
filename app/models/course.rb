class Course < ApplicationRecord
  belongs_to :user
  belongs_to :course_category

  validates :title, :description, :marketing_description, :language, :price, :level, presence: true
  validates :description, length: { minimum: 150 }
  validates :marketing_description, length: { maximum: 1300 }
  validates :title, uniqueness: true, length: { maximum: 70 }
  validates :price, numericality: { greater_than_or_equal_to: 0, less_than: 500_000 }
  validates :image,
            content_type: ['image/png', 'image/jpg', 'image/jpeg'],
            size: { less_than: 500.kilobytes, message: 'size should be under 500 kilobytes' }

  has_many :chapters, dependent: :destroy, inverse_of: :course
  has_many :lessons, dependent: :destroy, inverse_of: :course
  has_many :enrollments, dependent: :restrict_with_error
  has_many :user_lessons, through: :lessons
  has_many :course_tags, inverse_of: :course, dependent: :destroy
  has_many :tags, through: :course_tags
  has_many :comments, through: :lessons

  has_one_attached :image
  has_rich_text :description

  accepts_nested_attributes_for :chapters, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :lessons, reject_if: :all_blank, allow_destroy: true

  scope :latest, -> { limit(3).order(created_at: :desc) }
  scope :top_rated, -> { limit(3).order(average_rating: :desc, created_at: :desc) }
  scope :popular, -> { limit(3).order(enrollments_count: :desc, created_at: :desc) }
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :approved, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false) }


  LANGUAGES = %i[English Russian Polish Spanish].freeze
  def self.languages
    LANGUAGES.map { |language| [language, language] }
  end

  LEVELS = [:"All levels", :Beginner, :Intermediate, :Advanced].freeze
  def self.levels
    LEVELS.map { |level| [level, level] }
  end

  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  def bought(user)
    enrollments.where(user_id: [user.id], course_id: [id]).any?
  end

  def progress(user)
    user_lessons.where(user: user).count / lessons_count.to_f * 100 unless lessons_count.zero?
  end

  def calculate_income
    update_column :income, enrollments.map(&:price).sum
    user.calculate_course_income
  end

  def update_rating
    if enrollments.any? && enrollments.where.not(rating: nil).any?
      update_column :average_rating, enrollments.average(:rating).round(2).to_f
    else
      update_column :average_rating, 0
    end
  end

  def similiar_courses
    self.class.joins(:tags)
        .where.not(id: id)
        .where(tags: { id: tags.ids })
        .select(
          'courses.*',
          'COUNT(tags.*) AS tags_in_common'
        )
        .group(:id)
        .order(tags_in_common: :desc)
  end
end
