# frozen_string_literal: true

json.workout_plans do
  json.array! workout_plans do |workout_plan|
    json.partial! 'workout_plans/workout_plan', workout_plan: workout_plan
  end
end
