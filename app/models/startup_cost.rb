class StartupCost < ApplicationRecord
  belongs_to :business_plan

  # validates :item_name, presence: true
  # validates :baseline_cost, presence: true
end

