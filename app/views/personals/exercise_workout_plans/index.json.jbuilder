# frozen_string_literal: true

json.exercise_workout_plans do
  json.array! exercise_workout_plans do |exercise_workout_plan|
    json.partial!(
      'personals/exercise_workout_plans/exercise_workout_plan',
      exercise_workout_plan:
    )
  end
end
json.total_pages total_pages
