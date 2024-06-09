class Comment < ApplicationRecord
  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  belongs_to :user
	belongs_to :commentable, polymorphic: true

	validates :body, presence: true

  has_rich_text :body

end

