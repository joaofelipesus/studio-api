# frozen_string_literal: true

FactoryBot.define do
  factory :exercise_group do
    workout_plan
    execution_sequence { 1 }
  end
end
