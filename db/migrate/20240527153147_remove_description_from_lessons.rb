class RemoveDescriptionFromLessons < ActiveRecord::Migration[6.1]
  def change
    remove_column :lessons, :description, :text
    remove_column :lessons, :paid, :boolean, default: false
    remove_column :lessons, :position, :integer
    add_column    :lessons, :chapter_id, :bigint
    add_column    :lessons, :vimeo, :string
  end
end
