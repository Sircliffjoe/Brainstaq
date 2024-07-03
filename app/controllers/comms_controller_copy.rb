# Migration for categories
create_table :categories do |t|
  t.string :name
  t.timestamps
end

# Migration for skills
create_table :skills do |t|
  t.string :name
  t.timestamps
end

# Migration for business ideas
create_table :business_ideas do |t|
  t.string :name
  t.text :description
  t.text :problems
  t.text :solutions
  t.text :products_services
  t.text :market_info
  t.text :requirements
  t.references :category, foreign_key: true
  t.timestamps
end

# Join table for business ideas and skills
create_table :business_ideas_skills, id: false do |t|
  t.belongs_to :business_idea
  t.belongs_to :skill
end

# Example category
Category.create(name: 'Agriculture')

# Example skills
Skill.create(name: 'Carpentry')
Skill.create(name: 'Brainstorming')
Skill.create(name: 'Baking')
Skill.create(name: 'Researching')

# Example business idea
business_idea = BusinessIdea.create(
  name: 'Urban Farming Solutions',
  description: 'A comprehensive approach to urban farming...',
  problems: 'Lack of fresh produce in urban areas...',
  solutions: 'Implement vertical farming techniques...',
  products_services: 'Fresh vegetables, educational workshops...',
  market_info: 'Urban areas in Nigeria are experiencing...',
  requirements: 'Basic knowledge in agriculture, initial investment...',
  category: Category.find_by(name: 'Agriculture')
)

# Link skills to business idea
business_idea.skills << Skill.find_by(name: 'Carpentry')
business_idea.skills << Skill.find_by(name: 'Brainstorming')
business_idea.skills << Skill.find_by(name: 'Baking')
business_idea.skills << Skill.find_by(name: 'Researching')

class BusinessIdeasController < ApplicationController
  def generate
    @category = Category.find(params[:category_id])
    @skills = Skill.where(id: params[:skill_ids])
    @business_idea = find_matching_idea(@category, @skills)
    if @business_idea
      render json: @business_idea
    else
      render json: { error: 'No matching business idea found' }, status: :not_found
    end
  end

  private

  def find_matching_idea(category, skills)
    BusinessIdea.joins(:skills)
                .where(category: category)
                .where(skills: { id: skills.map(&:id) })
                .distinct
                .first
  end
end

def customize_idea(business_idea, user)
  {
    name: business_idea.name,
    description: customize_text(business_idea.description, user),
    problems: customize_text(business_idea.problems, user),
    solutions: customize_text(business_idea.solutions, user),
    products_services: customize_text(business_idea.products_services, user),
    market_info: customize_text(business_idea.market_info, user),
    requirements: customize_text(business_idea.requirements, user)
  }
end

def customize_text(text, user)
  text.gsub("#{business_idea.user.first_name}", user.first_name)
      .gsub("#{business_idea.user.last_name}", user.last_name)
      .gsub("#{business_idea.user.username}", user.username)
      .gsub("#{business_idea.user.country}", user.country)
end
