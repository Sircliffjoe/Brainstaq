class Category < ApplicationRecord
  has_many :ideas
  has_many :enterprises
  has_many :business_ideas
  has_many :posts
  has_many :business_idea_templates
  validates :name, presence: true, uniqueness: true

  def self.ransackable_associations(auth_object = nil)
    ["enterprises", "ideas"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
