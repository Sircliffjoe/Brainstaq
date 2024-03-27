class User < ApplicationRecord
  attr_accessor :login
  after_create :subscribe_to_free_plan
  enum status: [:inactive, :active]
  
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: %i[github google_oauth2]

  mount_uploader :image, ImageUploader

  enum subscription_plan: [:free, :startup, :enterprise]
  attribute :subscription_status, :integer, default: 0
  attribute :subscription_expiration_date, :datetime
  
  validates :username, presence: true
  validate :image_size_validation
  validates :bio, length: { maximum: 180 }

  # belongs_to :subscription_plan

  # include PublicActivity::Model
  # tracked only: [:create]
  
  #has_secure_password

  has_many :subscriptions
  has_many :subscription_plans, through: :subscriptions

  has_many :transactions, dependent: :destroy
  has_many :ideas, dependent: :destroy
  has_many :enterprises, dependent: :destroy
  has_many :business_plans, through: :enterprises
  has_many :donations #through: :ideas
  has_many :comments, dependent: :destroy
  # has_many :team_members, through: :enterprises

  has_many :conversations, foreign_key: :sender_id, dependent: :destroy
  has_many :visits, class_name: "Ahoy::Visit"

  acts_as_voter

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  # scope :with_subscription_plan_id, (lambda {|subscription_plan_id|
  #   where(subscription_plan_id: [*subscription_plan_id])})

  # scope :with_subscription_plan_name, (lambda {|subscription_plan_name|
  #   where('subscription_plans.plan_name = ?', subscription_plan_name).joins(:subscription_plan)})

  
  def full_name
    "#{first_name} #{last_name}"
  end

  def show
    @user = User.find(params[:id])
  end 
  
  def total_following
    Follow.where(followee_id: self.id).count
  end

  def total_followers
    Follow.where(follower_id: self.id).count
  end

  def self.from_omniauth(auth)
    user = User.find_by(email: auth.info.email)
    if user
      user.provider = auth.provider
      user.uid = auth.uid
      user.save
    else
      user = User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
    end
    user
  end
  
  # def user_rating
  #   self.user_rating = (self.ideas.count + self.comments.count)
  # end

  # def country_name
  #   country = ISO3166::Country[country_code]
  #   country.translations[I18n.locale.to_s] || country.name
  # end

  def self.search(query)  
    where("lower(ideas.title) LIKE :search OR lower(users.first_name) LIKE :search ", query: "%#{query.downcase}%").uniq   
  end

  def self.find_for_database_authentication warden_condition
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where(
      ["lower(username) = :value OR lower(email) = :value", 
        { value: login.strip.downcase}]).first
  end

  def donated_amount
    self.donated_amount = @donation.sum(:amount).to_f / 100
  end

  def funded_ideas_and_user
    self.donations.includes(idea: :user)
  end

  def subscribed_to?(plan_code)
    transactions.active.where(plan_code: plan_code).exists?
  end

  def can_create_enterprise?
    enterprise_count < 2
  end

  def can_create_business_plan?
    business_plan_count < 2
  end

  # after_create :setup_subscription_plan

  private

  # def setup_subscription_plan
  #   SubscriptionPlan.create(user_id: self.id, plan: "free", active_until: 12.months.from_now)
  # end

  def subscribe_to_free_plan
    subscription_plan = SubscriptionPlan.find_by(plan_name: "FREE")
    Subscription.create(user: self, subscription_plan: subscription_plan)
  end  

  def image_size_validation
    #errors[:image] << "should be less than 1MB" if image.size > 1.megabytes
    errors.add(:image, message: "should be less than 1MB") if image.size > 1.megabytes
  end
end