class Transaction < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  scope :active, -> { where("expires_on > ?", Date.today) }
end
