class CreateJoinTableUserSkill < ActiveRecord::Migration[6.1]
  def change
    create_join_table :users, :skills do |t|
      t.index [:user_id, :skill_id]
      t.index [:skill_id, :user_id]
    end
  end
end
