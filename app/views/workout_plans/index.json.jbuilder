# frozen_string_literal: true

json.workout_plans do
  json.array! workout_plans do |workout_plan|
    # rubocop:disable Style/HashSyntax
    json.partial! 'workout_plans/workout_plan', workout_plan: workout_plan
    # rubocop:enable Style/HashSyntax
  end
end

if paginate
  json.total_pages total_pages
  json.current_page current_page
end
