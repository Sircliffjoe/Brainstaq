class CreateSubscriptionPlansNew < ActiveRecord::Migration[6.1]
  def change
    create_table :subscription_plans, force: :cascade do |t|
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false
      t.string :plan_name
      t.integer :cost
      t.string :description
      t.boolean :recurring, default: false # Set default value for recurring
      t.string :paystack_plan_code
      t.integer :status, default: 0 # Set default value for status
      t.integer :duration # Add duration column (assuming it's an integer)
      t.index :paystack_plan_code, unique: true # Add unique index on paystack_plan_code
    end
  end
end
