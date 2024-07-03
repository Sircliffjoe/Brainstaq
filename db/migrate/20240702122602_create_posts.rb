class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :short_description
      t.text :content
      t.string :image
      t.string :category
      t.string :author
      t.datetime :date_posted

      t.timestamps
    end
  end
end
