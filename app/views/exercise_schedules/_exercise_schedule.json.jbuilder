# frozen_string_literal: true

json.exercise_schedule do
  json.id exercise_schedule.id
  json.exercises_group_id exercise_schedule.exercises_group_id
  json.rest exercise_schedule.rest
  json.repetitions exercise_schedule.repetitions
  json.exercise_sequence exercise_schedule.exercise_sequence
end
