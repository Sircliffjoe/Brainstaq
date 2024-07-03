class CreateBusinessIdeas < ActiveRecord::Migration[6.1]
  def change
    create_table :business_ideas do |t|
      t.string :name
      t.text :description
      t.text :problems_solved
      t.text :solutions
      t.text :products_services
      t.text :market_info
      t.text :requirements
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
