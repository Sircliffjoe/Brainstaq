class AddIntervalToEnterprises < ActiveRecord::Migration[6.1]
  def change
    add_column :enterprises, :interval, :string
    add_column :transactions, :enterprise_id, :integer
  end
end
