class AddPremiumDescriptionToCourses < ActiveRecord::Migration[6.1]
  def change
    remove_column :courses, :name, :string
    add_column :courses, :title, :string
    add_column :courses, :paid, :boolean, default: false
    add_column :courses, :premium_description, :text
  end
end
