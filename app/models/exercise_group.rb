# frozen_string_literal: true

class ExerciseGroup < ApplicationRecord
  belongs_to :workout_plan
end
