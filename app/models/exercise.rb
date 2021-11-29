# frozen_string_literal: true

class Exercise < ApplicationRecord
  include Activable

  belongs_to :muscular_group

  validates :name, presence: true
  validates :name, uniqueness: true
end
