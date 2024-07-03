class CreateBusinessIdeaTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :business_idea_templates do |t|
      t.string :name
      t.text :description
      t.text :problems
      t.text :solutions
      t.text :products_services
      t.text :market_info
      t.text :requirements
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
