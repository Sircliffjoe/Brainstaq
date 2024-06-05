class ChangeApprovedColumnInCourses < ActiveRecord::Migration[6.1]
  def change
    change_column :courses, :approved, :boolean, default: true
  end
end