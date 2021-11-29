# frozen_string_literal: true

FactoryBot.define do
  factory :exercise_workout_plan do
    workout_plan { create(:workout_plan) }
    exercise { create(:exercise) }
    exercise_sequence { 1 }
    rest { :free }
    repetitions { :pyramid }
  end
end
