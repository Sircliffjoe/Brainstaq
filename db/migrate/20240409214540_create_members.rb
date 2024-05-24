class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.integer :customer_code
      t.string  :first_name
      t.string  :last_name
      t.string  :email
      t.integer :phone_number
      t.string  :next_of_kin_email
      t.string  :address
      t.date    :date_of_birth
      t.string  :referal_name
      t.bigint  :payment_method_id
      t.string  :voucher_code
      t.bigint  :referring_customer_id
      t.string  :paystack_subscription_code
      t.string  :paystack_email_token
      t.string  :paystack_auth_code
      t.string  :paystack_cust_code
      t.bigint  :subscription_plan_id
      t.text    :image_data  

      t.timestamps
    end
  end
end
