class Transaction < ApplicationRecord
  belongs_to :enterprise, foreign_key: :enterprise_id

  def self.ransackable_attributes(auth_object = nil)
    ["amount", "channel", "created_at", "currency", "customer_code", "enterprise_id", "expires_on", "gateway_response", "id", "integer", "reference", "status", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["enterprise"]
  end
end
