module Brainstorm::States
  extend ActiveSupport::Concern

  STATES = %i[ setup conception vote voting_done ]

  included do
    kredis_enum :state_proxy, key: ->(b) { "brainstorm_state_#{b.token}" }, values: STATES, default: nil
  end

  def state
    state_proxy.value.to_s.inquiry
  end

  def state=(state)
    state_proxy.value = state
  end
end
