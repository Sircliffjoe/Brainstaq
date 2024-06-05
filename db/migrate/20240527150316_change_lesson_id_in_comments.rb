class ChangeLessonIdInComments < ActiveRecord::Migration[6.1]
  def change
    change_column_null :comments, :lesson_id, true
  end
end
