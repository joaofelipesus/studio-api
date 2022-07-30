# frozen_string_literal: true

FactoryBot.define do
  factory :exercise_schedule do
    exercise_sequence { 1 }
    rest { :free }
    repetitions { :pyramid }
    exercise
    exercises_group
  end
end
