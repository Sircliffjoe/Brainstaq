class CreateGeneratedIdeas < ActiveRecord::Migration[6.1]
  def change
    create_table :generated_ideas do |t|
      t.references :business_idea, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.text :problems
      t.text :solutions
      t.text :products_services
      t.text :market_info
      t.text :requirements

      t.timestamps
    end
  end
end
