# frozen_string_literal: true

json.exercises_group do
  json.id exercises_group.id
  json.execution_sequence exercises_group.execution_sequence
  json.exercise_schedules do
    json.array! exercises_group.exercise_schedules do |exercise_schedule|
      json.partial! 'exercise_schedules/exercise_schedule', exercise_schedule: exercise_schedule
    end
  end
end
