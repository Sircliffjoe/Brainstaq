class Enterprise < ApplicationRecord
	enum status: [:inactive, :active]
  validates :name, :address, :email, :phone_number, :country, :category, :image, :website_url, 
  :facebook_url, :twitter_url, :instagram_url, :user_id, :state, :city, presence: true

  validates :info, presence: true, length: {minimum: 100, maximum: 800}
  after_validation :set_slug, only: [:create, :update]
  default_scope { order(created_at: :desc)}
  validate :image_size_validation
	mount_uploader :image, ImageUploader

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_rich_text :info
  belongs_to :user, foreign_key: :user_id
  belongs_to :category

  has_many :transactions, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  has_many :business_plans, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :pitch_decks, dependent: :destroy
  has_many :portfolios, dependent: :destroy
  has_many :services, dependent: :destroy

  def to_param
    "#{id}-#{slug}"
  end

  def has_active_transaction?
    transactions.where('expires_on > ?', Date.today).exists?
  end

  private

  def set_slug
    self.slug = name.to_s.parameterize
  end

  def image_size_validation
    errors.add(:image, message: "should be less than 1MB") if image.size > 1.megabytes
  end
end
