class AddCommentableIdToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :commentable_id, :integer
    add_column :comments, :commentable_type, :string
    add_column :comments, :lesson_id, :bigint, null: false
  end
end

