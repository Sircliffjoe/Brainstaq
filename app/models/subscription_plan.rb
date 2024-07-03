class SubscriptionPlan < ApplicationRecord
  has_many :users
  has_many :features, dependent: :destroy
  has_many :subscriptions

  enum status: [:active, :deactivated]
  enum duration: [:monthly, :annually]


  validates :plan_name, :cost, :duration, :description, presence: true
  validates :recurring, :inclusion => {:in => [true, false]}

  accepts_nested_attributes_for :features, allow_destroy: true, reject_if: proc { |attr| attr['name'].blank? } 

  scope :active_plans, -> {
    where(status: 0)
  }

  def self.options_for_select
    order('LOWER(plan_name)').map { |e| [e.plan_name, e.id]}
  end

  def self.ransackable_attributes(auth_object = nil)
    ["cost", "created_at", "description", "duration", "id", "paystack_plan_code", "plan_name", "recurring", "status", "updated_at"]
  end
end
