class ChangeCategoryToForeignKey < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :category_id, :integer, foreign_key: true
    remove_column :posts, :category, :string
    add_index :posts, :category_id
  end
end