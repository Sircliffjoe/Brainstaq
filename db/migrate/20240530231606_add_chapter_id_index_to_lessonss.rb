class AddChapterIdIndexToLessonss < ActiveRecord::Migration[6.1]
  def change
    add_index :lessons, :chapter_id
  end
end
