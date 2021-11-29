# frozen_string_literal: true

FactoryBot.define do
  factory :exercise_workout_plan do
    workout_plan { nil }
    exercise { nil }
    repetitions { 'MyString' }
    rest { 'MyString' }
  end
end
