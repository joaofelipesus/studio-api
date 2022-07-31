# frozen_string_literal: true

json.exercise_schedule do
  json.id exercise_schedule.id
  json.workout_plan_id exercise_schedule.workout_plan_id
  json.exercises_group exercise_schedule.exercises_group_id
  json.execution_sequence exercise_schedule.execution_sequence
end
