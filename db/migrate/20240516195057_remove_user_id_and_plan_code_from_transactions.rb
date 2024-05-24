class RemoveUserIdAndPlanCodeFromTransactions < ActiveRecord::Migration[6.1]
  def change
    remove_index :transactions, :user_id
    remove_column :transactions, :user_id, :bigint
    remove_column :transactions, :plan_code, :string
  end
end
