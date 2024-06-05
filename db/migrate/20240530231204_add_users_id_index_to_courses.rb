class AddUsersIdIndexToCourses < ActiveRecord::Migration[6.1]
  def change
    add_index :courses, :user_id
  end
end
