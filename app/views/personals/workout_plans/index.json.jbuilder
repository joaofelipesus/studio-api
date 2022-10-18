# frozen_string_literal: true

json.workout_plans do
  json.array! paginated_data[:workout_plans] do |workout_plan|
    # rubocop:disable Style/HashSyntax
    json.partial! 'personals/workout_plans/workout_plan', workout_plan: workout_plan
    # rubocop:enable Style/HashSyntax
  end
end
json.total_pages paginated_data[:meta][:total_pages]
json.current_page paginated_data[:meta][:current_page]
