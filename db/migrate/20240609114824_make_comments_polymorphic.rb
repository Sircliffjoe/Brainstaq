class MakeCommentsPolymorphic < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :idea_id, :bigint
    remove_column :comments, :lesson_id, :bigint
    
    add_index :comments, [:commentable_type, :commentable_id]
  end
end