# frozen_string_literal: true

class WorkoutPlan < ApplicationRecord
  include Activable

  belongs_to :personal

  validates :name, presence: true
  validates :name, uniqueness: true
end
