# frozen_string_literal: true

class ExercisesGroup < ApplicationRecord
  belongs_to :workout_plan
  has_many :exercise_schedules, dependent: :destroy
end
