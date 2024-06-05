class Idea < ApplicationRecord 
  validates :title, :description, :overview, :impact, :donation_goal, :end_date, :category, :image, presence: true
  validate :not_in_past
  validates :category, presence: true
  after_validation :set_slug, only: [:create, :update]

  # extend FriendlyId
  # friendly_id :name, use: :slugged

  # include PublicActivity::Model
  # tracked

  default_scope { order(created_at: :desc)}
  
  mount_uploader :image, ImageUploader

  validate :image_size_validation

  belongs_to :user
  belongs_to :category
  
  has_many :comments, as: :commentable
  has_many :donors
  has_many :donations
  has_many :users, through: :donations
  has_many :perks, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  # has_many :line_items, inverse_of: :order

  accepts_nested_attributes_for :perks, allow_destroy: true, reject_if: proc { |attr| attr['title'].blank? } 

  acts_as_votable

  is_impressionable

  scope :active, ->{ where(status: "active") }
  scope :inactive, ->{ where(status: "inactive") }

  def to_param
    "#{id}-#{slug}"
  end

  def not_in_past
    if self.end_date.past?
      errors.add(:expiry_date, 'can not be in the past')
    end
  end

  def impressionist_count
    impressions.size
  end

  def donors
    # find users who donate to a specific campaign
  end

  def donors_count
    self.donations.count
  end

  def donated_amount
   self.donated_amount = donations.sum(:amount) / 100
  end

  def total_donations
    self.total_donations = Donations.sum(:amount) / 100
  end

  def funding_percent
    (self.donated_amount.to_f / self.donation_goal).round(2) * 100
  end

  def active?
    status == "active"
  end

  def inactive
    status == "inactive"
  end

  def expired?
    self.end_date < Time.now 
  end
  
  def purchased_perk(perk)
    
  end

  def relevance_bar
    self.relevance_bar = (self.impressions.size + self.get_likes.size + self.comments.size)
  end

  private

  def set_slug
    self.slug = title.to_s.parameterize
  end

  def image_size_validation
    #errors[:image] << "should be less than 1MB" if image.size > 1.megabytes
    errors.add(:image, message: "should be less than 1MB") if image.size > 1.megabytes
  end
end

