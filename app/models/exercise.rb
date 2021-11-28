# frozen_string_literal: true

class Exercise < ApplicationRecord
  belongs_to :muscular_group

  validates :name, :status, presence: true
  validates :name, uniqueness: true

  enum status: {
    active: 'ACTIVE',
    invactive: 'INACTIVE'
  }
end
