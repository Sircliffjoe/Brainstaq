class CreateJoinTableBusinessIdeasSkills < ActiveRecord::Migration[6.1]
  def change
    create_join_table :business_ideas, :skills do |t|
      t.index [:business_idea_id, :skill_id]
      t.index [:skill_id, :business_idea_id]
    end
  end
end
