# frozen_string_literal: true

class WorkoutPlan < ApplicationRecord
  include Activable

  belongs_to :personal

  has_many :exercise_workout_plans, dependent: :destroy
  has_many :exercises_groups, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true
end
