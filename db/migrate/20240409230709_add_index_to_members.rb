class AddIndexToMembers < ActiveRecord::Migration[6.1]
  def change
    add_index :members, :customer_code, unique: true
    add_index :members, :email
    add_index :members, :payment_method_id
    add_index :members, :phone_number, unique: true
    add_index :members, :referring_customer_id
    add_index :members, :subscription_plan_id
  end
end
