# frozen_string_literal: true

class ExerciseWorkoutPlan < ApplicationRecord
  belongs_to :workout_plan
  belongs_to :exercise
end
