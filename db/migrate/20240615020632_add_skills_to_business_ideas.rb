class AddSkillsToBusinessIdeas < ActiveRecord::Migration[6.1]
  def change
    add_column :business_ideas, :skill_id_1, :integer
    add_column :business_ideas, :skill_id_2, :integer
    add_column :business_ideas, :skill_id_3, :integer
    add_column :business_ideas, :skill_id_4, :integer

    add_foreign_key :business_ideas, :skills, column: :skill_id_1
    add_foreign_key :business_ideas, :skills, column: :skill_id_2
    add_foreign_key :business_ideas, :skills, column: :skill_id_3
    add_foreign_key :business_ideas, :skills, column: :skill_id_4
  end
end
