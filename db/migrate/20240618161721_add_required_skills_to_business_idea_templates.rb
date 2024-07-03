class AddRequiredSkillsToBusinessIdeaTemplates < ActiveRecord::Migration[6.1]
  def change
    add_column :business_idea_templates, :required_skills, :integer, array: true, default: []
  end
end
