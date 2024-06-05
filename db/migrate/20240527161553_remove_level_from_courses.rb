class RemoveLevelFromCourses < ActiveRecord::Migration[6.1]
  def change
    # Step 1: Add the column without the null: false constraint
    add_column :courses, :user_id, :bigint
    
    # Step 2: Add a temporary default value (e.g., setting it to the first user, if applicable)
    reversible do |dir|
      dir.up do
        # Assuming you have a default user you can set or handle accordingly
        # Set default user_id for existing courses here, e.g., setting it to the first user in the users table
        default_user_id = User.first&.id || 1  # Replace with your logic if necessary
        Course.update_all(user_id: default_user_id)
      end
    end
    
    # Step 3: Change the column to add the null: false constraint
    change_column_null :courses, :user_id, false
    
    # Remove and re-add other columns
    remove_column :courses, :level, :string, default: "Beginner", null: false
    add_column :courses, :level, :string, default: "All levels", null: false
    add_column :courses, :chapters_count, :integer, default: 0, null: false
    add_column :courses, :course_category_id, :integer
  end
end