# frozen_string_literal: true

json.exercises_group do
  json.id exercises_group.id
  json.execution_sequence exercises_group.execution_sequence
  json.workout_plan_id exercises_group.workout_plan_id
  json.exercise_schedules do
    json.array! exercises_group.exercise_schedules do |exercise_schedule|
      # rubocop:disable Style/HashSyntax
      json.partial! 'exercise_schedules/exercise_schedule', exercise_schedule: exercise_schedule
      # rubocop:enable Style/HashSyntax
    end
  end
end
