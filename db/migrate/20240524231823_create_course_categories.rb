class CreateCourseCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :course_categories do |t|
      t.bigint :category_id
      t.bigint :course_id
      t.timestamps
    end
    add_index :course_categories, :category_id
    add_index :course_categories, :course_id
  end
end
