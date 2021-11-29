# frozen_string_literal: true

json.exercise_workout_plan do
  json.id exercise_workout_plan.id
  json.exercise_id exercise_workout_plan.exercise_id
  json.workout_plan_id exercise_workout_plan.workout_plan_id
  json.rest exercise_workout_plan.rest
  json.repetitions exercise_workout_plan.repetitions
  json.exercise_sequence exercise_workout_plan.exercise_sequence
end
