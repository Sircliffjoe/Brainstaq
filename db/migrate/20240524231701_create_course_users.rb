class CreateCourseUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :course_users do |t|
      t.bigint :course_id, null: false
      t.bigint :user_id, null: false
      t.index :course_id
      t.index :user_id

      t.timestamps
    end
  end
end
