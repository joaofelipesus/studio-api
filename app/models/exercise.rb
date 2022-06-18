# frozen_string_literal: true

class Exercise < ApplicationRecord
  include Activable

  belongs_to :muscular_group
  belongs_to :personal

  validates :name, presence: true
  validates :name, uniqueness: true

  paginates_per 10
end
