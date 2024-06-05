class AddDescriptionToLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :description, :text
    add_column :lessons, :paid, :boolean, default: false
    add_column :lessons, :position, :integer
  end
end
