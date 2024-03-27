class AddTransactionReferenceToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :transaction_reference, :string
  end
end
