class Transaction < ApplicationRecord
  belongs_to :enterprise, foreign_key: :enterprise_id
end
