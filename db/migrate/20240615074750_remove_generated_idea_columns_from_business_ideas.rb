class RemoveGeneratedIdeaColumnsFromBusinessIdeas < ActiveRecord::Migration[6.1]
  def change
    remove_column :business_ideas, :name, :string
    remove_column :business_ideas, :description, :text
    remove_column :business_ideas, :problems_solved, :text
    remove_column :business_ideas, :solutions, :text
    remove_column :business_ideas, :products_services, :text
    remove_column :business_ideas, :market_info, :text
    remove_column :business_ideas, :requirements, :text
  end
end
