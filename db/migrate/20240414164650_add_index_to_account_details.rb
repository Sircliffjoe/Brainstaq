class AddIndexToAccountDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :account_details, :member_status, :integer
    add_reference :account_details, :member, index: true
  end
end
