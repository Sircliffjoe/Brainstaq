class AddPlanIdAndStatusToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :plan_id, :string
    add_column :subscriptions, :status, :string
  end
end
