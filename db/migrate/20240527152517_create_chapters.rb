class CreateChapters < ActiveRecord::Migration[6.1]
  def change
    create_table "chapters", force: :cascade do |t|
      t.integer "row_order"
      t.bigint "course_id", null: false
      t.string "title"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.string "slug"
      t.integer "lessons_count", default: 0, null: false
      t.index ["course_id"], name: "index_chapters_on_course_id"
      t.index ["slug"], name: "index_chapters_on_slug", unique: true
    end
  end
end
