class AddSkillIdsToBusinessIdeas < ActiveRecord::Migration[6.1]
  def change
    add_column :business_ideas, :skill_ids, :integer, array: true, default: []
    remove_column :business_ideas, :skill_id_1, :integer
    remove_column :business_ideas, :skill_id_2, :integer
    remove_column :business_ideas, :skill_id_3, :integer
    remove_column :business_ideas, :skill_id_4, :integer
  end
end
