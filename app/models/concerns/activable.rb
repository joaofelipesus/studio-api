# frozen_string_literal: true

module Activable
  extend ActiveSupport::Concern

  # Module used to set status of active or invacitve to a model, check presence and set enum to status attribute.
  included do
    validates :status, presence: true

    enum status: {
      active: 'ACTIVE',
      inactive: 'INACTIVE'
    }
  end
end
