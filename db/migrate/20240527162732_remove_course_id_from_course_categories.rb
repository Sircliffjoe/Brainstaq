class RemoveCourseIdFromCourseCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :course_categories, :category_id, :bigint
    remove_column :course_categories, :course_id,   :bigint
    add_column    :course_categories, :name,   :string
  
    add_column :users, :invitation_token, :string
    add_column :users, :invitation_created_at, :datetime
    add_column :users, :invitation_sent_at, :datetime
    add_column :users, :invitation_accepted_at, :datetime
    add_column :users, :invitation_limit, :integer
    add_column :users, :invited_by_type, :string
    add_column :users, :invited_by_id, :bigint
    add_column :users, :invitations_count, :integer, default: 0
    add_column :users, :stripe_customer_id, :string
  
    add_index :users, :invitation_token, unique: true
    add_index :users, :invited_by_id
    add_index :users, [:invited_by_type, :invited_by_id], name: "index_users_on_invited_by"
  end
end
