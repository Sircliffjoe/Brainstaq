class CreateFeaturesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :features, force: :cascade do |t|
      t.string :name
      t.string :description
      t.bigint :subscription_plan_id
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false
      t.index :subscription_plan_id
    end
  end
end
