class CreateLessonUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :lesson_users do |t|
      t.bigint :lesson_id, null: false
      t.bigint :user_id, null: false
      t.boolean :completed, default: false
      t.index :lesson_id
      t.index :user_id

      t.timestamps
    end
  end
end
