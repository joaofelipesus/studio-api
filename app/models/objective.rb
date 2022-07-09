# frozen_string_literal: true

class Objective < ApplicationRecord
  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :students
  # rubocop:enable Rails/HasManyOrHasOneDependent

  validates :name, presence: true
  validates :name, uniqueness: true
end
