class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :subscription_plan

  validates :user_id, presence: true
  validates :subscription_plan_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "end_date", "id", "plan_id", "start_date", "status", "subscription_plan_id", "transaction_reference", "updated_at", "user_id"]
  end
end