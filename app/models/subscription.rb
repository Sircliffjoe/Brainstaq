class Subscription < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :subscription_plan_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
