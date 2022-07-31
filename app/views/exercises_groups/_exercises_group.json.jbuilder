# frozen_string_literal: true

json.exercises_group do
  json.id exercises_group.id
  json.exercise_id exercises_group.exercise_id
  json.exercises_group exercises_group.exercises_group_id
  json.rest exercises_group.rest
  json.repetitions exercises_group.repetitions
  json.exercise_sequence exercises_group.exercise_sequence
end
