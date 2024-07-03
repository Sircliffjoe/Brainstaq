class User < ApplicationRecord
  attr_accessor :login

  devise :database_authenticatable, :registerable, :confirmable,:recoverable,
    :rememberable, :validatable, :trackable,:omniauthable, 
    omniauth_providers: %i[github google_oauth2]

  rolify

  mount_uploader :image, ImageUploader
  
  validates :username, presence: true
  validate :image_size_validation
  validates :bio, length: { maximum: 180 }

  has_many :courses, dependent: :nullify
  has_many :enrollments, dependent: :nullify
  has_many :user_lessons, dependent: :nullify
  has_many :students, through: :courses, source: :enrollments
  has_many :lessons, through: :user_lessons # lessons viewed by the user

  has_many :enrolled_courses, through: :enrollments, source: :course

  has_many :ideas, dependent: :destroy
  has_one  :enterprise, dependent: :destroy
  has_many :business_plans, through: :enterprises
  has_many :donations #through: :ideas
  has_many :comments, dependent: :destroy
  has_many :conversations, foreign_key: :sender_id, dependent: :destroy
  has_many :visits, class_name: "Ahoy::Visit"

  acts_as_voter

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users
  has_many :subscriptions
  has_and_belongs_to_many :skills
  has_many :business_ideas
  has_many :posts

  include PublicActivity::Model
  tracked only: %i[create destroy], owner: :itself

  def self.ransackable_attributes(auth_object = nil)
    ["admin", "bio", "business_plan_count", "comments_count", "confirmation_sent_at", 
    "confirmed_at", "country", "courses_count", "created_at", "current_sign_in_at", 
    "current_sign_in_ip", "customer_code", "email", "encrypted_password", "enrollments_count", 
    "enterprise_count", "expires", "expires_at", "first_name", "gender", "id", "image", 
    "instagram_url", "interval", "invitations_count", "invited_by_id", "invited_by_type", "last_name", 
    "last_sign_in_at", "last_sign_in_ip", "linkedin_url", "paystack_auth_code", "paystack_cust_code", 
    "paystack_subscription_code", "perk_subscriptions", "phone", "plan", "plan_subscription_id", 
    "reset_password_sent_at", "reset_password_token", "sign_in_count", "slug", "status", 
    "subscribed_to_plan", "subscription_plan_id", "twitter_url", 
    "unconfirmed_email", "updated_at", "user_lessons_count", "username", "website"]
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    self.admin
  end

  def show
    @user = User.find(params[:id])
  end
  
  def online?
    updated_at > 2.minutes.ago
  end

  def buy_course(course)
    enrollments.create(course: course, price: course.price)
  end

  def take_course(course)
    enrollments.create(course: course)
  end

  def view_lesson(lesson)
    view = user_lessons.find_or_create_by(lesson: lesson)
    view.increment!(:impressions)
  end

  def bought?(course)
    enrolled_courses.include?(course)
  end

  def enrolled_in?(course)
    enrollments.exists?(course: course)
  end

  def viewed?(lesson)
    lessons.include?(lesson)
  end
  
  def max_enterprises
    plan = subscription_plans.first.plan_name
    case plan
    when 'Startup'
      1
    when 'Premium'
      2
    when 'Enterprise'
      5
    else
      0
    end
  end
  
  def can_create_enterprise?
    enterprises.count < max_enterprises
  end

  def can_create_business_plan?
    business_plan_count < 2
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

  # def calculate_course_income
  #   update_column :course_income, courses.map(&:income).sum
  #   update_column :balance, (course_income - enrollment_expenses)
  # end

  # def calculate_enrollment_expenses
  #   update_column :enrollment_expenses, enrollments.map(&:price).sum
  #   update_column :balance, (course_income - enrollment_expenses)
  # end

  private
    
  def image_size_validation
    errors.add(:image, message: "should be less than 1MB") if image.size > 1.megabytes
  end

  def must_have_a_role
    errors.add(:roles, 'must have at least one role') unless roles.any?
  end
end