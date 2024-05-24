class CreateSubscriptionsNew < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions, force: :cascade do |t|
      t.bigint :user_id, null: false
      t.bigint :subscription_plan_id, null: false
      t.date :start_date, null: false
      t.date :end_date
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false
      t.string :transaction_reference
      t.string :plan_id
      t.string :status
    end

    add_foreign_key :subscriptions, :users, column: :user_id, on_delete: :cascade
    add_foreign_key :subscriptions, :subscription_plans, column: :subscription_plan_id, on_delete: :cascade
    
    add_index :subscriptions, :subscription_plan_id
    add_index :subscriptions, :user_id
  end
end
