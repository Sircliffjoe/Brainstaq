class AddPlanCodeToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :plan_code, :string
  end
end
