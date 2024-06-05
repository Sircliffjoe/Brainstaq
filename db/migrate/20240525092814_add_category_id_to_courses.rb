class AddCategoryIdToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :category_id, :integer
    remove_column :courses, :user_id, :bigint
  end
end
