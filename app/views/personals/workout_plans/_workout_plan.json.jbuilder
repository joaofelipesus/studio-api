# frozen_string_literal: true

json.workout_plan do
  json.id workout_plan.id
  json.name workout_plan.name
  json.personal_id workout_plan.personal_id
  json.exercises_groups do
    json.array! workout_plan.exercises_groups do |exercises_group|
      # rubocop:disable Style/HashSyntax
      json.partial! 'personals/exercises_groups/exercises_group', exercises_group: exercises_group
      # rubocop:enable Style/HashSyntax
    end
  end
end
