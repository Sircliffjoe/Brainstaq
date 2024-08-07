class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User' 
  belongs_to :followee, class_name: 'User'

  validates :follower_id, uniqueness: { scope: :followee_id }
  validates :followee_id, uniqueness: { scope: :follower_id }

  def follower_username
    follower.username
  end

  def followee_username
    followee.username
  end
end
