# frozen_string_literal: true

class ExercisesGroup < ApplicationRecord
  belongs_to :workout_plan
end
